-- Project 2 tables. Run once against the jobradar database.
CREATE TABLE IF NOT EXISTS events_inbox (
  id              SERIAL PRIMARY KEY,
  event_id        TEXT UNIQUE NOT NULL,
  type            TEXT NOT NULL,
  payload         JSONB,
  status          TEXT NOT NULL DEFAULT 'received', -- received | processing | retry | done | dead
  attempts        INT NOT NULL DEFAULT 0,
  next_attempt_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  claimed_at      TIMESTAMPTZ,
  last_error      TEXT,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_events_queue ON events_inbox(status, next_attempt_at);

CREATE TABLE IF NOT EXISTS crm_contacts (
  id            SERIAL PRIMARY KEY,
  email         TEXT UNIQUE NOT NULL,
  name          TEXT,
  stage         TEXT NOT NULL DEFAULT 'lead',
  amount        NUMERIC DEFAULT 0,
  last_event_id TEXT,
  updated_at    TIMESTAMPTZ DEFAULT now()
);
