# DocuSeal Hosting on Azure Container Apps

A Terraform module to host DocuSeal on Azure Container Apps.

- **Authors:** PaperCloud OSS Developers
- **Created on:** 06/02/2025

## Pre-requisites

Before provisioning this infrastructure with Terraform, we require you to have the following already provisioned:

1. A VNet that has subnets for hosting:
    1. Private Endpoints
    2. Container Apps (subnet delegated to `Microsoft.App/environments`)
2. A PostgreSQL database hosted on Azure with private endpoint to the same VNet associated and approved.
