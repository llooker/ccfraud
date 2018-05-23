view: cc_fraud_locations {
  label: "Locations"
  sql_table_name: rob.cc_fraud_locations ;;

  dimension: name_orig {
    primary_key: yes
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
    sql_latitude: round(${lat},1) ;;
    sql_longitude: round(${long},1) ;;
  }


  measure: count {
    type: count
    drill_fields: []
  }
}
