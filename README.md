# 📸 DATOU

**DATOU** is a modern marketplace platform connecting photographers, videographers, models, and agencies. Built with Flutter and powered by Supabase, DATOU provides a seamless experience for creative professionals to discover opportunities, manage bookings, and showcase their work.

## 🌟 Features

### 🎯 **Core Features**
- **Multi-Role Support**: Photographers, Videographers, Models, and Agencies
- **Smart Marketplace**: Browse and filter listings by location, price, and specialty
- **Booking Management**: Seamless booking system with calendar integration
- **Portfolio Showcase**: Rich media galleries for creative professionals
- **Real-time Chat**: Direct communication between clients and talent
- **Review System**: Build reputation through verified reviews

### 🎨 **Design & UX**
- **Glass Morphism UI**: Modern, elegant design with blur effects
- **Dark/Light Themes**: Automatic theme switching based on system preferences
- **Responsive Design**: Optimized for mobile, tablet, and desktop
- **Smooth Animations**: Fluid transitions and micro-interactions

### 🔐 **Security & Authentication**
- **Supabase Auth**: Secure user authentication and session management
- **Row Level Security (RLS)**: Database-level security policies
- **Environment Variables**: Secure configuration management

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:
- **Flutter SDK** (3.0 or higher)
- **Dart SDK** (3.0 or higher)
- **Xcode** (for iOS development)
- **Android Studio** (for Android development)
- **Git**

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Zachary0hill/DATOU-APP.git
   cd DATOU-APP/datou_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up environment variables**
   
   Create a `.env` file in the root directory:
   ```env
   SUPABASE_URL=your_supabase_project_url
   SUPABASE_ANON_KEY=your_supabase_anon_key
   APP_NAME=DATOU
   APP_VERSION=1.0.0
   ```

4. **Configure Supabase**
   
   Run the SQL schema in your Supabase project (see [Database Setup](#database-setup))

5. **Run the app**
   ```bash
   # For development
   flutter run
   
   # For specific platforms
   flutter run -d chrome    # Web
   flutter run -d ios       # iOS Simulator
   flutter run -d android   # Android Emulator
   ```

## 🗄️ Database Setup

### Supabase Schema

Run this SQL in your Supabase SQL editor to set up the database:

```sql
-- Enable necessary extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create custom types
CREATE TYPE user_role AS ENUM ('photographer', 'videographer', 'model', 'agency');
CREATE TYPE listing_type AS ENUM ('photoshoot', 'videoshoot', 'modeling', 'event');
CREATE TYPE booking_status AS ENUM ('pending', 'confirmed', 'completed', 'cancelled');
CREATE TYPE event_type AS ENUM ('photoshoot', 'videoshoot', 'meeting', 'consultation', 'availability', 'booking', 'other');
CREATE TYPE event_status AS ENUM ('pending', 'confirmed', 'cancelled', 'completed');

-- Users table (extends Supabase auth.users)
CREATE TABLE profiles (
    id UUID REFERENCES auth.users(id) PRIMARY KEY,
    email TEXT UNIQUE NOT NULL,
    full_name TEXT,
    role user_role NOT NULL,
    bio TEXT,
    location TEXT,
    phone TEXT,
    website TEXT,
    instagram TEXT,
    portfolio_url TEXT,
    profile_image_url TEXT,
    cover_image_url TEXT,
    hourly_rate DECIMAL(10,2),
    experience_years INTEGER,
    specialties TEXT[],
    equipment TEXT[],
    languages TEXT[],
    is_verified BOOLEAN DEFAULT FALSE,
    is_available BOOLEAN DEFAULT TRUE,
    rating DECIMAL(3,2) DEFAULT 0.00,
    total_reviews INTEGER DEFAULT 0,
    total_bookings INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Listings table
CREATE TABLE listings (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    description TEXT,
    type listing_type NOT NULL,
    price DECIMAL(10,2),
    duration_hours INTEGER,
    location TEXT,
    latitude DECIMAL(10,8),
    longitude DECIMAL(11,8),
    images TEXT[],
    tags TEXT[],
    requirements TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Bookings table
CREATE TABLE bookings (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    listing_id UUID REFERENCES listings(id) ON DELETE CASCADE,
    client_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    provider_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    start_date TIMESTAMP WITH TIME ZONE NOT NULL,
    end_date TIMESTAMP WITH TIME ZONE NOT NULL,
    total_amount DECIMAL(10,2),
    status booking_status DEFAULT 'pending',
    special_instructions TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Calendar Events table
CREATE TABLE calendar_events (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    description TEXT,
    start_date TIMESTAMP WITH TIME ZONE NOT NULL,
    end_date TIMESTAMP WITH TIME ZONE NOT NULL,
    type event_type NOT NULL,
    status event_status DEFAULT 'pending',
    location TEXT,
    booking_id UUID REFERENCES bookings(id) ON DELETE SET NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Reviews table
CREATE TABLE reviews (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    booking_id UUID REFERENCES bookings(id) ON DELETE CASCADE,
    reviewer_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    reviewee_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    rating INTEGER CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Portfolio table
CREATE TABLE portfolio_items (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    description TEXT,
    image_url TEXT NOT NULL,
    tags TEXT[],
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Applications table
CREATE TABLE applications (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    listing_id UUID REFERENCES listings(id) ON DELETE CASCADE,
    applicant_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    cover_letter TEXT,
    proposed_rate DECIMAL(10,2),
    status TEXT DEFAULT 'pending',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Enable Row Level Security
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE listings ENABLE ROW LEVEL SECURITY;
ALTER TABLE bookings ENABLE ROW LEVEL SECURITY;
ALTER TABLE calendar_events ENABLE ROW LEVEL SECURITY;
ALTER TABLE reviews ENABLE ROW LEVEL SECURITY;
ALTER TABLE portfolio_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE applications ENABLE ROW LEVEL SECURITY;

-- RLS Policies
CREATE POLICY "Users can view all profiles" ON profiles FOR SELECT USING (true);
CREATE POLICY "Users can update own profile" ON profiles FOR UPDATE USING (auth.uid() = id);

CREATE POLICY "Anyone can view active listings" ON listings FOR SELECT USING (is_active = true);
CREATE POLICY "Users can manage own listings" ON listings FOR ALL USING (auth.uid() = user_id);

CREATE POLICY "Users can view own bookings" ON bookings FOR SELECT USING (auth.uid() = client_id OR auth.uid() = provider_id);
CREATE POLICY "Users can create bookings" ON bookings FOR INSERT WITH CHECK (auth.uid() = client_id);
CREATE POLICY "Users can update own bookings" ON bookings FOR UPDATE USING (auth.uid() = client_id OR auth.uid() = provider_id);

CREATE POLICY "Users can view own events" ON calendar_events FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can manage own events" ON calendar_events FOR ALL USING (auth.uid() = user_id);

CREATE POLICY "Anyone can view reviews" ON reviews FOR SELECT USING (true);
CREATE POLICY "Users can create reviews for their bookings" ON reviews FOR INSERT WITH CHECK (auth.uid() = reviewer_id);

CREATE POLICY "Anyone can view portfolio items" ON portfolio_items FOR SELECT USING (true);
CREATE POLICY "Users can manage own portfolio" ON portfolio_items FOR ALL USING (auth.uid() = user_id);

CREATE POLICY "Users can view applications for their listings" ON applications FOR SELECT USING (
    auth.uid() = applicant_id OR 
    auth.uid() = (SELECT user_id FROM listings WHERE id = listing_id)
);
CREATE POLICY "Users can create applications" ON applications FOR INSERT WITH CHECK (auth.uid() = applicant_id);

-- Functions and Triggers
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_profiles_updated_at BEFORE UPDATE ON profiles
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_listings_updated_at BEFORE UPDATE ON listings
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_bookings_updated_at BEFORE UPDATE ON bookings
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_applications_updated_at BEFORE UPDATE ON applications
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
```

## 🏗️ Project Structure

```
datou_app/
├── lib/
│   ├── core/                    # Core utilities and configurations
│   │   ├── constants.dart       # App constants and configuration
│   │   ├── models/             # Data models (Freezed + JSON serializable)
│   │   ├── routing/            # App routing configuration
│   │   ├── theme/              # App themes and styling
│   │   └── ui/                 # Reusable UI components
│   ├── features/               # Feature-based architecture
│   │   ├── auth/              # Authentication (login, signup, etc.)
│   │   ├── calendar/          # Calendar and event management
│   │   ├── home/              # Home feed and dashboard
│   │   ├── listings/          # Marketplace listings
│   │   ├── main/              # Main navigation scaffold
│   │   ├── onboarding/        # User onboarding flow
│   │   └── profile/           # User profiles and portfolios
│   └── main.dart              # App entry point
├── assets/                     # Images, fonts, and other assets
├── test/                      # Unit and widget tests
└── platform folders/         # iOS, Android, Web, Desktop configurations
```

## 🎨 Design System

### Color Palette
- **Primary**: Glass morphism with blur effects
- **Dark Theme**: Deep blacks and grays with accent colors
- **Light Theme**: Clean whites and light grays

### Typography
- **Primary Font**: Baloo 2 (friendly, rounded)
- **Display Font**: Bakbak One (bold, impactful)

### Components
- **Glass Container**: Reusable glass morphism component
- **Custom Cards**: Specialized cards for listings, profiles, etc.
- **Responsive Grids**: Adaptive layouts for different screen sizes

## 🧪 Testing

Run tests with:

```bash
# Unit tests
flutter test

# Integration tests
flutter test integration_test/

# Test coverage
flutter test --coverage
```

## 📱 Platform Support

- ✅ **iOS** (iPhone, iPad)
- ✅ **Android** (Phone, Tablet)
- ✅ **Web** (Chrome, Safari, Firefox)
- ✅ **macOS** (Desktop)
- ✅ **Windows** (Desktop)
- ✅ **Linux** (Desktop)

## 🔧 Build & Deploy

### Development Build
```bash
flutter run --debug
```

### Production Build
```bash
# iOS
flutter build ios --release

# Android
flutter build apk --release
flutter build appbundle --release

# Web
flutter build web --release

# Desktop
flutter build macos --release
flutter build windows --release
flutter build linux --release
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Flutter Team** for the amazing framework
- **Supabase** for the backend infrastructure
- **Riverpod** for state management
- **Freezed** for immutable data classes

## 📞 Support

For support, email support@datou.app or join our community Discord.

---

**Built with ❤️ using Flutter & Supabase**