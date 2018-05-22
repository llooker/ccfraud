view: cc_fraud_dataset {
  sql_table_name: rob.cc_fraud ;;


  dimension: name_dest {
    group_label: "Transaction Information"
    label: "Destination ID"
    type: string
    sql: ${TABLE}.nameDest ;;
  }

  dimension: name_orig {
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
    group_label: "Transaction Information"
    label: "Transaction Amount ($)"
    type: number
    sql: ${TABLE}.amount ;;
    value_format_name: usd
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
    sql: CASE WHEN ${TABLE}.isFlaggedFraud = 1 THEN 'YES'
         ELSE 'NO' END;;
  }

  dimension: is_fraud {
    description: "Client Contacted Us About Fraud"
    label: "Is Fraud"
    group_label: "Fraud Validation"
    type: string
    sql: CASE WHEN ${TABLE}.isFraud = 1 THEN 'YES'
         ELSE 'NO' END;;
  }

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
#
#   dimension: location_filter {
#     type: yesno
#     sql:  ${location_origin} = ${location_destination};;
#   }


  dimension: origlat {
   hidden: yes
    type: number
    sql: ${TABLE}.origlat + .1  ;;
  }

  dimension: origlong {
    hidden: yes
    type: number
    sql: ${TABLE}.origlong  + .1 ;;
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

  measure: count {
    type: count
    drill_fields: [distance_between_origin_and_destination]
  }
}
