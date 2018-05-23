view: cc_fraud_locations {
  sql_table_name: rob.cc_fraud_locations ;;

  dimension: name_orig {
    hidden: yes
    type: string
    sql: ${TABLE}.nameOrig ;;
  }

  dimension: loctype {
    label: "Location Type"
    type: string
    sql: ${TABLE}.loctype ;;
  }

  dimension: lat {
    hidden: yes
    type: number
    sql: ${TABLE}.lat ;;
  }

  dimension: long {
    hidden: yes
    type: number
    sql: ${TABLE}.long ;;
  }

  dimension: location {
    type: location
    sql_latitude: ${lat} ;;
    sql_longitude: ${long} ;;
  }


  measure: count {
    type: count
    drill_fields: []
  }
}
