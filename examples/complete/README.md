# Complete VM Example

This example provisions a single VM using most module features.

## What This Example Shows

- VM creation with explicit sizing and boot config
- Security group selection via `security_group_names`
- Keypair authentication
- Cloud-init `user_data`
- Backup configuration
- Labels and resource timeouts

## Files

- `main.tf`: complete provider and module configuration

## How To Run

1. Go to this folder:

```bash
cd examples/complete
```

2. Initialize Terraform:

```bash
terraform init
```

3. Set required provider variables (API key/secret, organization, project).

4. Plan:

```bash
terraform plan
```

5. Apply:

```bash
terraform apply
```

6. Destroy when done:

```bash
terraform destroy
```

## Notes

- `protection_plan` should be the plan ID or UUID expected by the provider.
- This example uses `start_date`; alternatively you can use `weekday` (not both).
- Adjust flavor, image, network names, and zone to match your environment.
