view: cc_fraud_dataset {
  sql_table_name: rob.cc_fraud_dataset ;;

  dimension: name_dest {
    group_label: "Transaction Information"
    label: "Destination ID"
    type: string
    sql: ${TABLE}.nameDest ;;
  }

  dimension: name_orig {
    primary_key: yes
    group_label: "Transaction Information"
    label: "Origin ID"
    type: string
    sql: ${TABLE}.nameOrig ;;
  }

  dimension: type {
    group_label: "Transaction Information"
    label: "Transaction Type"
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: amount {
   hidden: yes
    type: number
    sql: ${TABLE}.amount ;;
    value_format_name: usd
  }

  measure: total_amount {
    group_label: "Transaction Information"
    label: "Transaction Amount ($)"
    type: sum
    value_format_name: usd
    sql: ${amount} ;;
  }


  dimension: oldbalance_org {
    group_label: "Balance Information"
    label: "Origin Old Balance"
    type: number
    sql: ${TABLE}.oldbalanceOrg ;;
  }

  dimension: newbalance_orig {
    group_label: "Balance Information"
    label: "Origin New Balance"
    type: number
    sql: ${TABLE}.newbalanceOrig ;;
  }

  dimension: oldbalance_dest {
    group_label: "Balance Information"
    label: "Destination Old Balance"
    type: number
    sql: ${TABLE}.oldbalanceDest ;;
  }

  dimension: newbalance_dest {
    group_label: "Balance Information"
    label: "Destination New Balance"
    type: number
    sql: ${TABLE}.newbalanceDest ;;
  }


  dimension: is_flagged_fraud {
    description: "Our System Flagged This Transaction as Fraud"
    group_label: "Fraud Validation"
    label: "Flagged as Fraud"
    type: string
    sql: CASE WHEN ${TABLE}.isFlaggedFraud = 1 THEN 'Yes'
         ELSE 'No' END;;
  }

  dimension: is_fraud {
    description: "Client Contacted Us About Fraud"
    label: "Is Fraud"
    group_label: "Fraud Validation"
    type: string
    sql: CASE WHEN ${TABLE}.isFraud = 1 THEN 'Yes'
         ELSE 'No' END;;
  }

  measure: algorithm_success_rate {
    description: "% of Fraud That Was Flagged"
    type: number
    sql:1.0 * sum(${TABLE}.isFlaggedFraud) / sum(${TABLE}.isFraud) ;;
    value_format_name: percent_0
  }

    measure: fraud_count {
    type: number
    value_format_name: percent_2
    sql: 1.0 * sum(${TABLE}.isFraud)/${count} ;;
  }

  measure: count_percent_of_total_fraud {
    label: "Percent of Total Fraud"
    type: percent_of_total
    sql: ${fraud_count} ;;
  }

#   dimension: item_gross_margin_percentage_tier {
#     type: tier
#     sql: 100*${item_gross_margin_percentage} ;;
#     tiers: [0, 10, 20, 30, 40, 50, 60, 70, 80, 90]
#     style: interval
#   }


  dimension: location_origin {
    group_label: "Location Information"
    type: location
    sql_latitude: round(${origlat},1) ;;
    sql_longitude: round(${origlong},1) ;;
  }

  dimension: location_destination {
    group_label: "Location Information"
    type: location
    sql_latitude: round(${destlat},1) ;;
    sql_longitude: round(${destlong},1) ;;
  }

  dimension: distance_between_origin_and_destination {
    group_label: "Location Information"
    label: "Distance in Miles"
    type: distance
    start_location_field: location_origin
    end_location_field: location_destination
    units: miles
  }

  dimension: city {
    group_label: "Location Information"
    label: "Origin City"
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: state {
    group_label: "Location Information"
    label: "Origin State"
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: county {
    group_label: "Location Information"
    label: "Origin County"
    type: string
    sql: ${TABLE}.county ;;
  }

#
#   dimension: location_filter {
#     type: yesno
#     sql:  ${location_origin} = ${location_destination};;
#   }


  dimension: origlat {
   hidden: yes
    type: number
    sql: ${TABLE}.origlat +.1 ;;
  }

  dimension: origlong {
    hidden: yes
    type: number
    sql: ${TABLE}.origlong +.1;;
  }

  dimension: destlat {
    hidden: yes
    type: number
    sql: ${TABLE}.destlat ;;
  }

  dimension: destlong {
    hidden: yes
    type: number
    sql: ${TABLE}.destlong ;;
  }



  measure: average_distance {
    type: average
    sql: ${distance_between_origin_and_destination};;
    value_format: "0.00\" mi\""
    #value_format_name: decimal_2
    drill_fields: [name_orig, name_dest, distance_between_origin_and_destination]
  }

  measure: count{
    label: "Total Transactions"
    type: count
    drill_fields: [distance_between_origin_and_destination]
  }
}
