## Bigtable Instance
resource "google_bigtable_instance" "bigtable_instance" {
  # Name of the Bigtable instance.
  name = "bigtable-instance"

  # Configuration block for defining a cluster within the instance.
  cluster {
    # Unique ID for the cluster.
    cluster_id = "main-cluster"

    # The compute zone where the cluster will be created.
    zone = var.zone

    # The number of nodes for the cluster.
    num_nodes = 1

    # The storage type: "SSD".
    storage_type = "SSD"
  }

}