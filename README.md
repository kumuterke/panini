# Secure Panini inventory site

This package separates the public catalogue from the admin editor.

## Files

- `index.html`: read-only customer page
- `manage-4f7a9c2e.html`: admin login/editor
- `config.js`: Supabase project URL and anon key
- `supabase-setup.sql`: database, seed data and Row Level Security policies

## Setup

1. Create a Supabase project.
2. In Authentication → Users, create only your admin account.
3. Copy your admin user's UUID.
4. Open `supabase-setup.sql`, replace `YOUR_ADMIN_USER_UUID`, and run it in the SQL Editor.
5. Copy Project URL and anon public key into `config.js`.
6. Upload the complete folder to a static host.

The public page only receives SELECT permission. Add, update and delete operations are blocked by database Row Level Security unless the signed-in user UUID is the configured admin UUID.

## Important security note

The unusual admin filename is only a convenience and is not the security control. Anyone can eventually discover a static page URL. Real protection comes from Supabase Auth and Row Level Security. Never place a Supabase service-role key or your password in the repository.

## Hosting note

GitHub Pages is a static host. GitHub's published limits say it is not intended as free hosting for a site primarily facilitating commercial transactions. For a small catalogue linking to Kleinanzeigen, review those limits and consider Cloudflare Pages, Netlify, or another static host if needed.
