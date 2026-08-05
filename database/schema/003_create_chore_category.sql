/*
====================================================
Table: chore_category

Purpose:
Stores household-specific categories used to organize
chores.

Sprint:
Sprint 1.3
====================================================
*/

CREATE TABLE chore_category (

    chore_category_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    household_id UUID NOT NULL,

    chore_category_name VARCHAR(100) NOT NULL,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL,

    created_by UUID,

    updated_at TIMESTAMPTZ,

    updated_by UUID,

    deleted_at TIMESTAMPTZ,

    deleted_by UUID,

    is_deleted BOOLEAN NOT NULL DEFAULT FALSE,


    CONSTRAINT fk_chore_category_household
        FOREIGN KEY (household_id)
        REFERENCES household(household_id),


    CONSTRAINT uq_chore_category_name_per_household
        UNIQUE (household_id, chore_category_name)

);