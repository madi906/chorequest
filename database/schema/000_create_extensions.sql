/*
====================================================
File: 000_create_extensions.sql

Purpose:
Enable PostgreSQL extensions required by ChoreQuest.

This script should always be executed before any
CREATE TABLE scripts.
====================================================
*/

CREATE EXTENSION IF NOT EXISTS pgcrypto;