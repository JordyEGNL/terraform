resource "proxmox_vm_qemu" "resource-name" {
    name        = "terraform-demo-01"
    tags        = "terraform"
    vmid        = 800

    target_node = "lab-pve-01"
    bios        = "ovmf"
    cores       = 2
    memory      = 512
    scsihw      = "virtio-scsi-pci"
    boot        = "order=scsi0;ide2"
    iso         = "Synology:iso/ubuntu-22.04.4-live-server-amd64.iso"

    disks {
        scsi {
            scsi0 {
                disk {
                    size    = "32"
                    storage = "local-lvm"
                }
            }
        }
    }
   
}