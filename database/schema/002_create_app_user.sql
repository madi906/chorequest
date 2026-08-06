/*
====================================================
Table: app_user

Purpose:
Stores users (parents and children) belonging to a household.

Sprint:
Sprint 1.2
====================================================
*/

CREATE TABLE app_user (

    app_user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    household_id UUID NOT NULL,

    app_user_name VARCHAR(100) NOT NULL,

    app_user_email VARCHAR(255) UNIQUE,,

    app_user_phone VARCHAR(30),

    user_role VARCHAR(20) NOT NULL,

    app_user_birthday DATE,

    avatar_url VARCHAR(500),

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    last_login_at TIMESTAMPTZ,

    created_at TIMESTAMPTZ NOT NULL,

    created_by UUID,

    updated_at TIMESTAMPTZ,

    updated_by UUID,

    deleted_at TIMESTAMPTZ,

    deleted_by UUID,

    is_deleted BOOLEAN NOT NULL DEFAULT FALSE,

    CONSTRAINT fk_app_user_household
        FOREIGN KEY (household_id)
        REFERENCES household(household_id)

);