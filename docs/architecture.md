# ChoreQuest Architecture

## Overview

ChoreQuest is a portfolio project that demonstrates enterprise application design using the Microsoft Power Platform together with a relational database.

The solution is designed following Microsoft's Business Applications architecture principles while using PostgreSQL as the primary development database. The database model is intentionally designed to remain portable to Microsoft Dataverse, Azure SQL Database, Microsoft SQL Server, or SharePoint Online Lists with minimal redesign.

The objective is to demonstrate skills expected of a Microsoft Power Platform Developer while establishing a strong foundation for progressing towards a Microsoft Business Applications Solution Architect role.

---

# Architecture Principles

The solution follows several key architectural principles:

- Business-first design
- Database-first modelling
- Separation of concerns
- Reusable business logic
- Low-code application development
- Secure by design
- Scalable architecture
- Technology portability

---

# Solution Architecture

```
                   ChoreQuest

                  Presentation Layer
                 Microsoft Power Apps
                         │
                         ▼
              Business Process Layer
               Microsoft Power Automate
                         │
                         ▼
                  Data Access Layer
              Standard SQL Data Model
                         │
                         ▼
          PostgreSQL (Supabase Development)

         Future Migration Targets

      • Microsoft Dataverse
      • Azure SQL Database
      • Microsoft SQL Server
      • SharePoint Online Lists
```

---

# Solution Layers

## Presentation Layer

Technology

- Microsoft Power Apps (Canvas Apps)

Responsibilities

- User interface
- Navigation
- Forms
- Validation
- Role-based visibility
- User experience

---

## Business Process Layer

Technology

- Microsoft Power Automate

Responsibilities

- Approval workflows
- Notifications
- Scheduled reminders
- Business automation
- Integration
- Audit processing

---

## Data Layer

Primary Development Database

- PostgreSQL
- Supabase

Development Tools

- DBeaver
- PostgreSQL SQL

Design Goals

- Normalised relational model
- Portable schema
- Strong referential integrity
- Auditability
- Performance

Future Migration Targets

- Microsoft Dataverse
- Azure SQL Database
- Microsoft SQL Server
- SharePoint Online Lists (where appropriate)

---

## Reporting Layer

Current

- Power Apps dashboards

Future

- Microsoft Power BI
- Executive dashboards
- Family activity reports
- Chore completion analytics

---

# Security Architecture

Authentication

Current

- Supabase Authentication

Future

- Microsoft Entra ID
- Microsoft 365

Authorisation

Application Roles

- Parent
- Child

Future Roles

- Administrator
- Teacher
- Guest

---

# Business Rules

Examples

- Parents create chores.
- Parents assign chores.
- Children complete chores.
- Parents approve completed chores.
- Points are awarded only after approval.
- Every point transaction is recorded.
- Every important action is auditable.

---

# Technology Stack

## Microsoft Platform

- Power Apps
- Power Automate
- Power BI (Future)
- Microsoft Entra ID (Future)

## Database

- PostgreSQL
- Supabase

## Development

- Visual Studio Code
- Git
- GitHub
- DBeaver
- draw.io

---

# Future Evolution

The architecture is intentionally designed to evolve without major redesign.

Future enhancements include:

- Microsoft Dataverse
- Azure SQL Database
- Microsoft SQL Server
- Power Pages
- Microsoft Teams integration
- AI Builder
- Azure Functions
- REST APIs

---

# Portfolio Objective

This project demonstrates practical skills in:

- Microsoft Power Platform
- Solution Architecture
- Relational Database Design
- Business Process Automation
- Enterprise Documentation
- Modern Development Practices

The architecture prioritises clean design, maintainability, portability, and scalability rather than being tightly coupled to a single data platform.

---
Version: 0.6
Status: Draft
Last Updated: August 2026
Owner: Akmal Hadi