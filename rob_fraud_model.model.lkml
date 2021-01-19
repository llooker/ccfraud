connection: "bigquery"

include: "*.view.lkml"         # include all views in this project
#include: "*.dashboard.lookml"  # include all dashboards in this project

explore: cc_fraud_dataset {
  label: "Credit Card Fraud"

 join: cc_fraud_locations {
  relationship: one_to_many
  sql_on: ${cc_fraud_dataset.name_orig} = ${cc_fraud_locations.name_orig};;
  }
}



# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }
