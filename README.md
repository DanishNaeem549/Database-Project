# Danish Naeem — Portfolio Website

A full-stack, production-ready personal portfolio: React (Vite + Tailwind) front-end, Node.js/Express backend, MongoDB Atlas database, JWT-protected admin dashboard, and a working contact-form email pipeline.
```
danish-portfolio/
├── frontend/   React + Vite + Tailwind + Framer Motion
└── backend/    Node.js + Express + MongoDB + JWT + Nodemailer
```
## 1. Pages

| Page | Route | Notes |
|---|---|---|
| Home | `/` | Hero, About, Skills, Projects (filterable), Why Hire Me, Testimonials, CTA |
| Services | `/services` | 10 services, filterable cards |
| Contact | `/contact` | Validated form → saves to MongoDB + sends emails |
| Thank You | `/thank-you` | Shown after a successful submission |
| Admin Login | `/admin/login` | JWT login |
| Admin Dashboard | `/admin/dashboard` | Protected route — view/search/mark-read/delete/export CSV |
| 404 | `*` | Any unmatched route |


## 3. Backend Setup

```bash
cd backend
npm install
cp .env.example .env
```
Fill in `.env`:
- `MONGO_URI` — your Atlas connection string
- `JWT_SECRET` — any long random string
- `SMTP_USER` / `SMTP_PASS` — Gmail address + App Password
- `NOTIFY_EMAIL` — where inquiry notifications get sent
- `ADMIN_EMAIL` / `ADMIN_PASSWORD` — credentials for the first admin account

Create the admin account, then start the server:

```bash
npm run seed:admin   # creates the one admin user, run once
npm run dev           # http://localhost:5000
```

Health check: `GET http://localhost:5000/api/health`

## 4. Frontend Setup

```bash
cd frontend
npm install
cp .env.example .env    # set VITE_API_URL if backend isn't on localhost:5000
npm run dev              # http://localhost:5173
```
Log in to the dashboard at `/admin/login` using the admin credentials from `.env`.

## 5. REST API Reference

| Method | Route | Access | Description |
|---|---|---|---|
| POST | `/api/auth/login` | Public | Admin login → returns JWT |
| GET | `/api/auth/me` | Private | Current admin profile |
| POST | `/api/contact` | Public | Submit a contact inquiry |
| GET | `/api/contact` | Private | List contacts (`?search=&status=&page=&limit=`) |
| GET | `/api/contact/:id` | Private | Single contact |
| PUT | `/api/contact/status/:id` | Private | Update status (`unread`/`read`/`responded`) |
| DELETE | `/api/contact/:id` | Private | Delete a contact |
| GET | `/api/contact/export/csv` | Private | Download all contacts as CSV |

Private routes require `Authorization: Bearer <token>`.

## 6. Security Implemented

- Password hashing with bcrypt (12 salt rounds)
- JWT authentication with expiry
- `helmet` for secure HTTP headers
- CORS restricted to `CLIENT_URL`
- `express-rate-limit` on all `/api` routes
- `xss-clean` input sanitization
- Honeypot field + server-side validation on the contact form
- All secrets in environment variables, never committed

## 7. SEO Implemented

- Per-page `<title>` and meta description (`Seo.jsx`)
- Open Graph + Twitter Card tags
- JSON-LD structured data (`Person` schema)
- `robots.txt` and `sitemap.xml` in `frontend/public`
- Semantic HTML, `alt` text on images, lazy-loaded project images

Run a Lighthouse audit against the built site to confirm scores before deployment; the biggest levers left in your control are compressing/replacing the placeholder Unsplash project images with optimized local assets and adding your own real content.

## 8. Deployment Guide

### Database — MongoDB Atlas
1. Create a free cluster, add a database user, and allow network access from anywhere (or your hosts' IPs).
2. Copy the connection string into `MONGO_URI`.

### Backend — Render
1. Push `backend/` to a GitHub repo (or the monorepo, with root directory set to `backend`).
2. New Web Service on [Render](https://render.com) → connect the repo.
3. Build command: `npm install` — Start command: `npm start`.
4. Add all variables from `.env` in Render's Environment tab.
5. After deploy, run the admin seed once via Render's shell: `npm run seed:admin`.

### Frontend — Vercel
1. Push `frontend/` to GitHub (root directory `frontend` if monorepo).
2. Import the repo on [Vercel](https://vercel.com).
3. Framework preset: Vite. Build command: `npm run build`. Output directory: `dist`.
4. Add environment variable `VITE_API_URL` = your Render backend URL + `/api`.
5. Deploy. Update `CLIENT_URL` in the backend's env to match the final Vercel domain, then redeploy the backend so CORS allows it.



