/**
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

locals {
  cluster_type = "simple-regional"
}

provider "google" {
  credentials = "${file(var.credentials_path)}"
  region      = "${var.region}"
}

module "gke" {
  source             = "../../"
  project_id         = "${var.project_id}"
  name               = "${local.cluster_type}-cluster${var.cluster_name_suffix}"
  regional           = true
  region             = "${var.region}"
  network            = "${var.network}"
  subnetwork         = "${var.subnetwork}"
  ip_range_pods      = "${var.ip_range_pods}"
  ip_range_services  = "${var.ip_range_services}"
  kubernetes_version = "1.11.5-gke.4"
  node_version       = "1.11.5-gke.4"
  service_account    = "${var.compute_engine_service_account}"
}

data "google_client_config" "default" {}
