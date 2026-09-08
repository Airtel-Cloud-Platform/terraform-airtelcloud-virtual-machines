# Multiple VMs Example

This example provisions multiple VMs by iterating over a local map with `for_each`.

## What This Example Shows

- Multi-VM creation from one module block
- Per-VM flavor selection using `locals.vms`
- Shared networking and authentication settings

## Files

- `main.tf`: local VM definitions + module `for_each`

## How To Run

1. Go to this folder:

```bash
cd examples/multiple-vms
```

2. Initialize Terraform:

```bash
terraform init
```

3. Provide required provider credentials and project details.

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

- To add or remove VMs, update the `locals.vms` map in `main.tf`.
- Use stable keys in `locals.vms` to avoid unnecessary resource replacement.
- Ensure flavor names and image/network values exist in your target project and region.
