ABSVMLC2 ;OAKLAND/DPC-VSS MIGRATION;8/20/2002
 ;;4.0;VOLUNTARY TIMEKEEPING;**31,33**;Jul 1994
 ;
SAVE ;Saves the list of codes to Service Code multiple in Migration Log file
 ;
 N ABSFDA,ABSIEN,ABSIENS,SRVCD
 D ABSIEN^ABSVMUT1 Q:'ABSIEN
 F I=1:1 S SRVCD=$P($T(SRVS+I),";;",2) Q:SRVCD=""  D
 . S ABSFDA(503339.54,"+"_I_","_ABSIEN_",",.01)=SRVCD
 D UPDATE^DIE("E","ABSFDA","ABSIENS")
 Q
 ;Loads IENs for national Service codes
LDSRVS ;
 N ABSIEN,SRVCD,I
 D ABSIEN^ABSVMUT1 Q:'ABSIEN
 K SCDS ;Array of IENs of service codes
 S SRVCD=""
 F  S SRVCD=$O(^ABS(503339.5,ABSIEN,4,"B",SRVCD)) Q:SRVCD=""  D
 . N SRVIEN,FOUNDIEN
 . D FIND^DIC(503332,,"@","X",SRVCD,,"B",,,"FOUNDIEN")
 . F I=1:1 S SRVIEN=$G(FOUNDIEN("DILIST",2,I)) Q:SRVIEN=""  D
 . . S SCDS(SRVIEN)=""
 . . Q
 . Q
 Q
 ;
SRVS ;
 ;;100
 ;;108
 ;;111
 ;;112
 ;;113
 ;;113
 ;;114
 ;;115
 ;;116
 ;;117
 ;;118
 ;;119
 ;;120
 ;;121
 ;;122
 ;;123
 ;;126
 ;;127
 ;;128
 ;;129
 ;;132
 ;;133
 ;;134
 ;;135
 ;;136
 ;;137
 ;;138
 ;;139
 ;;142
 ;;143
 ;;151
 ;;160
 ;;170
 ;;181
 ;;182
 ;;190
 ;;199
 ;;200
 ;;250
 ;;260
 ;;270
 ;;771
 ;;772
 ;;773
 ;;774
 ;;775
 ;;776
 ;;777
 ;;000
 ;;000T
 ;;004
 ;;004T
 ;;005
 ;;005T
 ;;011
 ;;011C
 ;;011T
 ;;041
 ;;100T
 ;;108E
 ;;108T
 ;;111T
 ;;112T
 ;;113T
 ;;114T
 ;;115T
 ;;116H
 ;;116T
 ;;116V
 ;;117A
 ;;117B
 ;;117D
 ;;117E
 ;;117F
 ;;117T
 ;;118E
 ;;118H
 ;;118T
 ;;119T
 ;;120T
 ;;121T
 ;;122S
 ;;122T
 ;;123T
 ;;126T
 ;;127T
 ;;128T
 ;;129T
 ;;132T
 ;;133T
 ;;134B
 ;;134C
 ;;134D
 ;;134E
 ;;134T
 ;;135A
 ;;135B
 ;;135E
 ;;135M
 ;;135R
 ;;135T
 ;;135V
 ;;136A
 ;;136B
 ;;136C
 ;;136D
 ;;136F
 ;;136T
 ;;136Z
 ;;137T
 ;;138T
 ;;139T
 ;;142T
 ;;143T
 ;;151T
 ;;160T
 ;;170A
 ;;170T
 ;;190T
 ;;250A
 ;;250D
 ;;250H
 ;;270A
 ;;270B
 ;;270C
 ;;270D
 ;;270E
 ;;500T
 ;;
 ;End of Service Codes
