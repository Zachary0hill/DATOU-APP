# Calendar Feature

This feature provides a comprehensive calendar system for users to manage their events, appointments, and gigs.

## Features

- **Interactive Calendar**: Monthly view with event indicators
- **Event Management**: Create, view, and manage calendar events
- **Event Types**: Support for different event types (photoshoot, videoshoot, meeting, consultation, other)
- **Event Status**: Track event status from scheduled to completed
- **Real-time Updates**: Live updates using Supabase realtime subscriptions
- **User-specific Events**: Events are tied to specific users as organizers or participants

## Database Schema

To use this calendar feature, you need to create the following table in your Supabase database:

```sql
-- Create the calendar_events table
CREATE TABLE calendar_events (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT,
    start_time TIMESTAMPTZ NOT NULL,
    end_time TIMESTAMPTZ NOT NULL,
    location TEXT NOT NULL,
    type TEXT NOT NULL CHECK (type IN ('photoshoot', 'videoshoot', 'meeting', 'consultation', 'other')),
    status TEXT NOT NULL DEFAULT 'scheduled' CHECK (status IN ('scheduled', 'confirmed', 'inProgress', 'completed', 'cancelled')),
    organizer_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    participant_ids UUID[] DEFAULT '{}',
    metadata JSONB DEFAULT '{}',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create indexes for better performance
CREATE INDEX idx_calendar_events_organizer_id ON calendar_events(organizer_id);
CREATE INDEX idx_calendar_events_start_time ON calendar_events(start_time);
CREATE INDEX idx_calendar_events_participant_ids ON calendar_events USING GIN(participant_ids);
CREATE INDEX idx_calendar_events_status ON calendar_events(status);

-- Create RLS (Row Level Security) policies
ALTER TABLE calendar_events ENABLE ROW LEVEL SECURITY;

-- Policy: Users can view events they organize or participate in
CREATE POLICY "Users can view their events" ON calendar_events
    FOR SELECT USING (
        auth.uid() = organizer_id OR
        auth.uid() = ANY(participant_ids)
    );

-- Policy: Users can create events as organizers
CREATE POLICY "Users can create events" ON calendar_events
    FOR INSERT WITH CHECK (auth.uid() = organizer_id);

-- Policy: Users can update events they organize
CREATE POLICY "Users can update their events" ON calendar_events
    FOR UPDATE USING (auth.uid() = organizer_id);

-- Policy: Users can delete events they organize
CREATE POLICY "Users can delete their events" ON calendar_events
    FOR DELETE USING (auth.uid() = organizer_id);

-- Create a trigger to automatically update the updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_calendar_events_updated_at
    BEFORE UPDATE ON calendar_events
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();
```

## Usage

### 1. Calendar Screen
The main calendar screen displays a monthly calendar with events marked on their respective dates. Users can:
- Navigate between months
- Tap on dates to view events for that day
- Tap the "Today" button to quickly jump to the current date
- Tap the "+" button to create new events

### 2. Event Creation
Users can create events by providing:
- **Title**: Event name
- **Type**: Category of event (photoshoot, videoshoot, meeting, etc.)
- **Date**: When the event occurs
- **Time**: Start and end times
- **Location**: Where the event takes place
- **Description**: Optional additional details

### 3. Event Details
Tapping on an event shows a detailed view with:
- Event information
- Status indicator
- Option to edit (coming soon)

## State Management

The calendar feature uses Riverpod providers for state management:

- `calendarEventsProvider`: Fetches all events for the current user
- `selectedDateProvider`: Tracks the currently selected date
- `eventsForSelectedDateProvider`: Gets events for the selected date
- `upcomingEventsProvider`: Fetches upcoming events

## File Structure

```
lib/features/calendar/
├── data/
│   ├── calendar_models.dart      # Data models (CalendarEvent, EventType, EventStatus)
│   └── calendar_repository.dart  # Supabase integration
├── logic/
│   └── calendar_providers.dart   # Riverpod providers
└── ui/
    ├── calendar_screen.dart      # Main calendar view
    └── create_event_screen.dart  # Event creation form
```

## Dependencies

- `table_calendar`: For the calendar widget
- `hooks_riverpod`: State management
- `supabase_flutter`: Backend integration
- `intl`: Date formatting

## Future Enhancements

- Edit existing events
- Delete events
- Event reminders and notifications
- Recurring events
- Event sharing and collaboration
- Calendar export/import
- Different calendar views (week, day)
- Event conflict detection