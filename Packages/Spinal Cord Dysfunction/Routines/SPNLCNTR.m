SPNLCNTR ;HIRMFO-WAA; SCI Center indicator;7/1/96
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
 ;;
 ; This function takes a VAMC pointer from the institution file
 ; and compares it to a list of SCI station number and returns
 ; 1/0 value.
 ; 
 ;Entry point is SCI
 ;Input
 ;   SPNLVA = Pointer value to local institution file.
 ;            (Please note this is not the station number
 ;             is is the IEN of a station with in the Institution
 ;             File.  For example 486 may be the IEN with in
 ;             the institution file for HINES VAMC but HINES station
 ;             Number is 578)
 ;
 ;Output
 ;  SPNLANS = This varable is a binary indicator.  1 (one) indicates
 ;            that the pointer from SPNLVA is a SCI center. 0 (zero)
 ;            indicates that the Site is NOT a SCI center.
 ;
SCI(SPNLVA) ; Main entry point
 S SPNLANS=0
 N SPNLSITE
 S SPNLSITE=+$G(^DIC(4,+SPNLVA,99)) ; Get the site Number
 I SPNLSITE D
 .N SPNLCNT,SPNLTAB
 .F SPNLCNT=1:1 S SPNLTAB=$P($T(TABLE+SPNLCNT),";",3) Q:'+SPNLTAB  D  Q:SPNLANS
 ..I $P(SPNLTAB,U)=+SPNLVA S SPNLANS=1
 ..Q
 .Q
 Q SPNLANS
 ; Table is a listing of all SCI Center Numbers and Names
 ; the format of the data is as follows.
 ;
 ;<tab>;;STATION_NUMBER^SITE_NAME
 ;
TABLE ;;Start of the table
 ;;501^ALBUQUERQUE
 ;;509^AUGUSTA
 ;;525^BROCKTON/WEST ROXBURY
 ;;526^BRONX
 ;;533^CASTLE POINT
 ;;541^CLEVELAND
 ;;546^MIAMI
 ;;549^DALLAS
 ;;561^EAST ORANGE
 ;;578^HINES
 ;;580^HOUSTON
 ;;590^HAMPTON
 ;;600^LONG BEACH
 ;;614^MEMPHIS
 ;;640^PALO ALTO
 ;;652^RICHMOND
 ;;657^ST. LOUIS
 ;;663^SEATTLE
 ;;664^SAN DIEGO
 ;;665^SEPULVEDA
 ;;671^SAN ANTONIO
 ;;672^SAN JUAN
 ;;673^TAMPA
 ;;688^WASHINGTON DC
 ;;695^MILWAUKEE
 ;;
