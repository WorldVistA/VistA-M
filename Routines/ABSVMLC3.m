ABSVMLC3 ;OAKLAND/DPC-VSS MIGRATION;8/20/2002
 ;;4.0;VOLUNTARY TIMEKEEPING;*31*;Jul 1994
 ;
 ;Loads codes for Scheduled Workdays.
LDWKS ;
 N WKCD,I,J
 K WCDS
 ;Array of valid work codes.
 ;At WCDS(ien), IEN in file #503333
 ;At WCDS("CD",code), actual code.
 F I=1:1 S WKCD=$P($T(WKS+I),";;",2) Q:WKCD=""  D
 . N WKIEN,FOUNDIEN
 . D FIND^DIC(503333,,"@","X",WKCD,,"B",,,"FOUNDIEN")
 . F J=1:1 S WKIEN=$G(FOUNDIEN("DILIST",2,J)) Q:WKIEN=""  D
 . . S WCDS(WKIEN)=""
 . . Q
 . S WCDS("CD",WKCD)=""
 . Q
 Q
 ;
WKS ;
 ;;0
 ;;1
 ;;2
 ;;3
 ;;4
 ;;5
 ;;6
 ;;7
 ;;8
 ;;9
 ;;#
 ;;%
 ;;&
 ;;&
 ;;*
 ;;+
 ;;/
 ;;A
 ;;B
 ;;C
 ;;D
 ;;E
 ;;F
 ;;G
 ;;H
 ;;I
 ;;J
 ;;K
 ;;L
 ;;M
 ;;N
 ;;O
 ;;P
 ;;Q
 ;;R
 ;;S
 ;;T
 ;;U
 ;;V
 ;;W
 ;;X
 ;;Y
 ;;Z
 ;;
 ; End of work schedule codes
LDAWDS ;
 N AWDCD,I,J
 K ACDS ;Array of IENs of valid award codes.
 F I=1:1 S AWDCD=$P($T(AWDS+I),";;",2) Q:AWDCD=""  D
 . N AWDIEN,FOUNDIEN
 . D FIND^DIC(503337,,"@","X",AWDCD,,"C",,,"FOUNDIEN")
 . F J=1:1 S AWDIEN=$G(FOUNDIEN("DILIST",2,J)) Q:AWDIEN=""  D
 . . S ACDS(AWDIEN)=""
 . . Q
 . Q
 Q
 ;
AWDS ;
 ;;00
 ;;16
 ;;14
 ;;24
 ;;02
 ;;04
 ;;06
 ;;07
 ;;08
 ;;12
 ;;18
 ;;20
 ;;22
 ;;15
 ;;17
 ;;21
 ;;25
 ;;19
 ;;23
 ;;50
 ;;03
 ;;05
 ;;26
 ;;27
 ;;28
 ;;29
 ;;30
 ;;31
 ;;32
 ;;33
 ;;34
 ;;35
 ;;36
 ;;
 ;End of award codes
 Q
