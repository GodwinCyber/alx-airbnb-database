```sql
  // Use DBML to define your database structure
  // Docs: https://dbml.dbdiagram.io/docs

  Table User {
    user_id UUID [pk, increment]
    first_name varchar [not null]
    last_name  varchar [not null]
    email varchar [unique, not null]
    password_hash varchar [not null]
    phone_number varchar [null]
    role enum(guest, host, admin) [not null]
    created_at timestamp
  }

  Table Property {
    property_id uuid [pk]
    host_id fk [ref: > User.user_id]
    name varchar [not null]
    description text [not null]
    location varchar [not null]
    price_per_night decimal [not null]
    created_at timestamp
    updated_at timestamp
  }

  Table Booking {
    booking_id uuid [primary key]
    property_id fk [ref: > Property.property_id]
    user_id fk [ref: > User.user_id]
    start_date date [not null]
    end_date date [not null]
    total_price decimal [not null]
    status Enum(pending, confirmed, cncalled)
    created_at timestamp
  }

  Table Payment {
    payment_id uuid [primary key]
    booking_id fk [ref: > Booking.booking_id]
    amount decimal [not null]
    payment_date timestamp
    payment_method Enum(credited_at, palpay, stripe)
  }

  Table Review {
    review_id uuid [primary key]
    property_d fk [ref: > Property.property_id]
    user_id fk [ref: > User.user_id]
    rating integer [not null, note: 'CHECK (rating >= 1 AND rating <= 5)']
    comment text [not null]
    created_at timestamp
  }

  Table Message {
    message_id uuid [primary key]
    sender_id uuid [ref: > User.user_id]
    recipeint_id uuid [ref: > User.user_id]
    message_body text [not null]
    sent_at timestamp
  }

// Ref user_posts: posts.user_id > users.id // many-to-one

// Ref: users.id < follows.following_user_id

// Ref: users.id < follows.followed_user_id

```