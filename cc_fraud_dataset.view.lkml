view: cc_fraud_dataset {
  label: "Fraud Data"
  sql_table_name: rob.cc_fraud_dataset ;;

  dimension: name_dest {
    group_label: "Transaction Information"
    label: "Destination ID"
    type: string
    sql: ${TABLE}.nameDest ;;
    drill_fields: [detail*]
  }

  dimension: name_orig {
    primary_key: yes
    group_label: "Transaction Information"
    label: "Origin ID"
    type: string
    sql: ${TABLE}.nameOrig ;;
    drill_fields: [detail*]
  }

  dimension: type {
    group_label: "Transaction Information"
    label: "Transaction Type"
    type: string
    sql: ${TABLE}.type ;;
    link: {
      label: "{{value}} Detail Dashboard"
      url: "/dashboards/261?Transaction%20Type={{ value | encode_uri }}"
      icon_url: "http://www.looker.com/favicon.ico"
    }
    drill_fields: [detail*]
  }

  dimension: amount {
   hidden: yes
    type: number
    sql: ${TABLE}.amount ;;
    drill_fields: [detail*]
    value_format_name: usd
  }

  measure: total_amount {
    group_label: "Transaction Information"
    label: "Transaction Amount ($)"
    type: sum
    value_format_name: usd
    sql: ${amount} ;;
    drill_fields: [detail*]
  }


  dimension: oldbalance_org {
    group_label: "Balance Information"
    label: "Origin Old Balance"
    type: number
    sql: ${TABLE}.oldbalanceOrg ;;
    drill_fields: [detail*]
  }

  dimension: newbalance_orig {
    group_label: "Balance Information"
    label: "Origin New Balance"
    type: number
    sql: ${TABLE}.newbalanceOrig ;;
    drill_fields: [detail*]
  }

  dimension: oldbalance_dest {
    group_label: "Balance Information"
    label: "Destination Old Balance"
    type: number
    sql: ${TABLE}.oldbalanceDest ;;
    drill_fields: [detail*]
  }

  dimension: newbalance_dest {
    group_label: "Balance Information"
    label: "Destination New Balance"
    type: number
    sql: ${TABLE}.newbalanceDest ;;
    drill_fields: [detail*]
  }


  dimension: is_flagged_fraud {
    description: "Our System Flagged This Transaction as Fraud"
    group_label: "Fraud Validation"
    label: "Flagged as Fraud"
    type: string
    sql: CASE WHEN ${TABLE}.isFlaggedFraud = 1 THEN 'Yes'
         ELSE 'No' END;;
    drill_fields: [detail*]
  }

  dimension: is_fraud {
    description: "Client Contacted Us About Fraud"
    label: "Is Fraud"
    group_label: "Fraud Validation"
    type: string
    sql: CASE WHEN ${TABLE}.isFraud = 1 THEN 'Yes'
         ELSE 'No' END;;
    drill_fields: [detail*]
  }

  measure: algorithm_success_rate {
    description: "% of Fraud That Was Flagged"
    type: number
    sql:1.0 * sum(${TABLE}.isFlaggedFraud) / sum(${TABLE}.isFraud) ;;
    value_format_name: percent_0
#     filters: {
#       field: cc_fraud_dataset.is_flagged_fraud
#       value: "No"
#     }
    drill_fields: [detail*]
  }

    measure: fraud_count {
    type: count_distinct
    sql: 1.0 * sum(${TABLE}.isFraud) ;;
      filters: {
        field: cc_fraud_dataset.is_fraud
        value: "Yes"
      }
      drill_fields: [detail*]
  }

  measure: flagged_fraud_count {
    type: count_distinct
    sql: 1.0 * sum(${TABLE}.isFlaggedFraud) ;;
    filters: {
      field: cc_fraud_dataset.is_flagged_fraud
      value: "Yes"
    }
    drill_fields: [detail*]
    }


  measure: count_percent_of_total_fraud {
    label: "Percent of Total Fraud"
    type: percent_of_total
    sql: ${fraud_count} ;;
#     filters: {
#       field: cc_fraud_dataset.is_fraud
#       value: "Yes"
#     }
    drill_fields: [detail*]
  }

  dimension: transaction_amount_tier {
    group_label: "Transaction Information"
    type: tier
    sql: ${amount} ;;
    tiers: [10000, 50000, 100000, 1000000]
    style: integer
    drill_fields: [detail*]
  }


  dimension: location_origin {
    group_label: "Location Information"
    type: location
    sql_latitude: round(${origlat},1) ;;
    sql_longitude: round(${origlong},1) ;;
    drill_fields: [name_orig, type, is_fraud, is_flagged_fraud,location_origin,location_destination, total_amount]

  }

  dimension: location_destination {
    group_label: "Location Information"
    type: location
    sql_latitude: round(${destlat},1) ;;
    sql_longitude: round(${destlong},1) ;;
    drill_fields: [name_orig, type, is_fraud, is_flagged_fraud,location_origin,location_destination, total_amount]

  }

  dimension: distance_between_origin_and_destination {
    group_label: "Location Information"
    label: "Distance in Miles"
    drill_fields: [name_orig, type, is_fraud, is_flagged_fraud,location_origin,location_destination, total_amount]
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
    drill_fields: [detail*]
  }

  dimension: state {
    group_label: "Location Information"
    label: "Origin State"
    type: string
    sql: ${TABLE}.state ;;
    link: {
      label: "{{value}} Detail Dashboard"
      url: "/dashboards/261?Origin%20State={{ value | encode_uri }}"
      icon_url: "http://www.looker.com/favicon.ico"
    }
    drill_fields: [detail*]
  }

  dimension: county {
    group_label: "Location Information"
    label: "Origin County"
    type: string
    sql: ${TABLE}.county ;;
    drill_fields: [detail*]
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
    drill_fields: [detail*]
  }

  measure: count{
    label: "Total Transactions"
    type: count
    drill_fields: [detail*]
  }

set: detail {
  fields: [name_orig, type, is_fraud, is_flagged_fraud, city, state, total_amount]
}

}
