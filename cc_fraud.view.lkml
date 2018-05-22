view: cc_fraud {
  sql_table_name: rob.cc_fraud ;;

  dimension: amount {
    type: number
    sql: ${TABLE}.amount ;;
  }

  dimension: destlat {
    type: number
    sql: ${TABLE}.destlat ;;
  }

  dimension: destlong {
    type: number
    sql: ${TABLE}.destlong ;;
  }

  dimension: is_flagged_fraud {
    type: number
    sql: ${TABLE}.isFlaggedFraud ;;
  }

  dimension: is_fraud {
    type: number
    sql: ${TABLE}.isFraud ;;
  }

  dimension: name_dest {
    type: string
    sql: ${TABLE}.nameDest ;;
  }

  dimension: name_orig {
    type: string
    sql: ${TABLE}.nameOrig ;;
  }

  dimension: newbalance_dest {
    type: number
    sql: ${TABLE}.newbalanceDest ;;
  }

  dimension: newbalance_orig {
    type: number
    sql: ${TABLE}.newbalanceOrig ;;
  }

  dimension: oldbalance_dest {
    type: number
    sql: ${TABLE}.oldbalanceDest ;;
  }

  dimension: oldbalance_org {
    type: number
    sql: ${TABLE}.oldbalanceOrg ;;
  }

  dimension: origlat {
    type: number
    sql: ${TABLE}.origlat ;;
  }

  dimension: origlong {
    type: number
    sql: ${TABLE}.origlong ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
