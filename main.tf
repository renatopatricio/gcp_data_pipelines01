

module "bigquery-dataset-gasolina" {
  source  = "C:\Users\renato.patricio\OneDrive - COMPASSO TECNOLOGIA LTDA\Documentos\Projetos\Stack - GCP Terraform\gcp_data_pipelines01\modules\bigquery"
  dataset_id                  = "gasolina_brasil_rp"
  dataset_name                = "gasolina_brasil_rp"
  description                 = "Dataset a respeito do histórico de preços da Gasolina no Brasil a partir de 2004_rp"
  project_id                  = var.project_id
  location                    = var.region
  delete_contents_on_destroy  = true
  deletion_protection = false
  access = [
    {
      role = "OWNER"
      special_group = "projectOwners"
    },
    {
      role = "READER"
      special_group = "projectReaders"
    },
    {
      role = "WRITER"
      special_group = "projectWriters"
    }
  ]
  tables=[
    {
        table_id           = "tb_historico_combustivel_brasil_dez_22",
        description        = "Tabela com as informacoes de preço do combustível ao longo dos anos"
        time_partitioning  = {
          type                     = "DAY",
          field                    = "data",
          require_partition_filter = false,
          expiration_ms            = null
        },
        range_partitioning = null,
        expiration_time = null,
        clustering      = ["produto","regiao_sigla", "estado_sigla"],  
        labels          = {
          name    = "stack_data_pipeline"
          project  = "gasolina"
        },
        deletion_protection = true
        schema = file("./bigquery/schema/gasolina_brasil/tb_historico_combustivel_brasil_dez_22.json")
    }
  ]
}

module "bucket-raw" {
  source  = "./modules/gcs"

  name       = "tbf-pipeline-stack-combustiveis-brasil-raw"
  project_id = var.project_id
  location   = var.region
}

module "bucket-curated" {
  source  = "./modules/gcs"

  name       = "tbf-pipeline-stack-combustiveis-brasil-curated"
  project_id = var.project_id
  location   = var.region
}

module "bucket-pyspark-tmp" {
  source  = "./modules/gcs"

  name       = "tbf-pipeline-stack-combustiveis-brasil-pyspark-tmp"
  project_id = var.project_id
  location   = var.region
}

module "bucket-pyspark-code" {
  source  = "./modules/gcs"

  name       = "tbf-pipeline-stack-combustiveis-brasil-pyspark-code"
  project_id = var.project_id
  location   = var.region
}




