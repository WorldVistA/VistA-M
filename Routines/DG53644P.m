DG53644P ;BPFO/JRC - Home Telehealth Patient POST Install;10 January 2005 ; 4/8/08 10:02am
 ;;5.3;Registration;**644**;Aug 13, 1993;Build 11
 ;
EN ;Main entry point
 ;Init variables
 N VIEIP,LINK,DGARRAY,SITE,FLAG,RESPONSE
 S DGARRAY="^TMP(""DGHT"",$J,""IPARRAY"")"
 S SITE=+$P($$SITE^VASITE(),U,3),(LINK,RESPONSE)=0
 ;
 ;Setup ip address array
 D ARRAY
 ;
 ;Resolve ip address to use
 S VIEIP="",VIEIP=$O(@DGARRAY@(SITE,VIEIP))
 ;
 ;No ip address resolved, enter manually? if flag = 1 abort
 I VIEIP="" D ASKYN I 'RESPONSE D ERRMSG K @DGARRAY Q
 ;
 ;If response = 1, enter ip adress manually if flag = 1 abort
 I RESPONSE S VIEIP=0 D ASKIP I 'VIEIP D ERRMSG K @DGARRAY Q
 ;
 ;Order thru HL Logical Link file and retrieve IEN for 'DGHT' Link
 S LINK=$O(^HLCS(870,"B","DG HTH",LINK))
 ;
 ;If DG HTH logical link not found display message and quit
 I 'LINK K @DGARRAY D ERRMSG Q
 ;
 ;Update HL Logical Link file (#870)
 D BMES^XPDUTL("DG HTH Logical Link has been found ")
 D BMES^XPDUTL("Updating IP Address field (#400.01) ")
 I VIEIP D
 .;Prepare DIE filer call
 .N DGHFDA,DGHERR
 .S DGHFDA(870,LINK_",",400.01)=VIEIP
 .D FILE^DIE("EK","DGHFDA","DGHERR")
 .I $D(DGHERR) D ERRMSG Q
 .D BMES^XPDUTL("DG HTH Logical Link ip address updated successfully. ")
 D MENUS
 Q
 ;
ARRAY ;Set VIE IP Address Array
 ;Input  : DGARRAY - ip address array
 ;Output : VIE ip address array
 ;         @DGARRAY@(station,VieIpAddress) =  ""
 N OFF,TEXT,STATION,IP
 F OFF=1:1 S TEXT=$P($T(TABLE+OFF),";;",2) Q:TEXT="END"  D
 .S STATION=$P(TEXT,"^",1),IP=$P(TEXT,"^",2)
 .I STATION=""!(IP="") Q
 .S @DGARRAY@(STATION,IP)=""
 Q
 ;
ASKIP ;Prompt user for VIE IP address
 N DIR,DIRUT,X,Y
 S DIR(0)="F^^K:X'?1.3N1"".""1.3N1"".""1.3N1"".""1.3N X"
 S DIR("?",1)="Enter a valid IP address using the following format: nnn.nnn.nnn.nnn"
 S DIR("?")="Or '??' for a list of available station numbers & IP addresses."
 S DIR("??")="^D VIEHELP^DG53644P"
 S DIR("A")="Enter local VIE IP address"
 D ^DIR
 I $D(DIRUT) Q
 S VIEIP=Y
 Q
 ;
VIEHELP ;Help text listing Local VIE address"
 N OFF,TEXT,IP
 F OFF=1:1 S TEXT=$P($T(TABLE+OFF),";;",2) Q:TEXT="END"  D
 .S STATION=$P(TEXT,"^",1),IP=$P(TEXT,"^",2)
 .I STATION=""!(IP="") Q
 .W ?3,STATION,?12,IP,!
 Q
ASKYN ;Ask user if they want to enter IP address manually
 N DIR,DIRUT,X,Y
 S DIR(0)="Y"
 S DIR("A",1)="Unable to resolve VIE IP address."
 S DIR("A")="Would you like to enter it manually"
 D ^DIR
 I $D(DIRUT)!('Y) S FLAG=1 Q
 S RESPONSE=Y
 Q
 ;
ERRMSG ;Problem encountered updating IP address notify user
 D BMES^XPDUTL("DG HTH Logical Link's IP address was not updated. ")
 D MES^XPDUTL("See patch description for instructions on how ")
 D MES^XPDUTL("to update the IP address at a later time. ")
 Q
 ;
MENUS ;Place HTH menu options out of order
 N OPTION,MENU,TEXT
 ;Delete HTH main menu from registration options.
 S OPTION="DGHT HOME TELEHEALTH"
 F MENU="DG REGISTRATION MENU","DG SUPERVISOR MENU" D
 .D DELETE^XPDMENU(MENU,OPTION)
 D BMES^XPDUTL("Implementation of HTH requires OCC coordination/approval; hence the following")
 D BMES^XPDUTL("list of HTH menu options have been placed out of order by the installation.")
 S OPTION="",TEXT="Activation of option requires OCC approval."
 F OPTION="DGHT HOME TELEHEALTH","DGHT PATIENT SIGNUP","DGHT PATIENT INACTIVATION","DGHT SUMMARY REPORT","DGHT TRANSMISSION REPORT" D
 .D OUT^XPDMENU(OPTION,TEXT)
 .D BMES^XPDUTL("["_OPTION_"]")
 Q
TABLE ;VIE IP address array table syntax - station ^ vie ip
 ;;516^10.64.10.136
 ;;660^10.154.2.54
 ;;657^10.123.139.63
 ;;613^10.40.106.46
 ;;528^10.21.253.165
 ;;HEC^10.61.193.83
 ;;528^10.21.253.169
 ;;HEC^10.61.193.88
 ;;688^10.41.0.18
 ;;518^10.8.66.64
 ;;523^10.9.0.99
 ;;650^10.11.1.30
 ;;689^10.12.8.37
 ;;580^10.133.188.116
 ;;517^10.50.50.24
 ;;608^10.8.143.73
 ;;561^10.30.21.175
 ;;503^10.32.11.27
 ;;558^10.48.138.44
 ;;402^10.14.128.29
 ;;620^10.30.21.180
 ;;529^10.32.129.50
 ;;589^10.120.137.84
 ;;526^10.30.21.185
 ;;512^10.42.14.165
 ;;637^10.50.148.34
 ;;540^10.33.120.113
 ;;542^10.34.22.100
 ;;674^10.137.10.30
 ;;671^10.140.159.107
 ;;504^10.145.252.221
 ;;630^10.30.21.165
 ;;405^10.14.55.53
 ;;562^10.33.184.77
 ;;659^10.51.1.122
 ;;632^10.30.21.170
 ;;595^10.35.136.65
 ;;460^10.39.10.30
 ;;565^10.51.138.130
 ;;658^10.49.138.24
 ;;646^10.37.34.86
 ;;590^10.48.10.89
 ;;509^10.57.224.115
 ;;521^10.59.15.164
 ;;534^10.56.224.105
 ;;631^10.13.97.24
 ;;693^10.38.14.110
 ;;652^10.49.50.60
 ;;544^10.60.205.80
 ;;557^10.61.224.94
 ;;673^10.69.48.45
 ;;642^10.36.41.66
 ;;619^10.62.224.103
 ;;679^10.63.224.238
 ;;573^10.65.10.44
 ;;672^10.68.130.68
 ;;546^10.67.12.49
 ;;581^10.73.100.123
 ;;596^10.74.100.123
 ;;614^10.76.100.124
 ;;757^10.81.1.96
 ;;548^10.70.31.219
 ;;603^10.75.100.123
 ;;626^10.78.100.123
 ;;538^10.82.1.249
 ;;621^10.72.100.123
 ;;539^10.80.2.46
 ;;583^10.89.4.94
 ;;541^10.83.1.69
 ;;610^10.90.1.40
 ;;552^10.85.1.29
 ;;550^10.94.10.133
 ;;506^10.93.80.134
 ;;695^10.98.2.38
 ;;515^10.92.1.85
 ;;537^10.97.8.33
 ;;676^10.103.2.132
 ;;553^10.91.0.74
 ;;578^10.101.1.64
 ;;556^10.100.1.18
 ;;607^10.102.2.65
 ;;655^10.88.63.68
 ;;502^10.129.24.29
 ;;598^10.128.5.226
 ;;586^10.130.12.207
 ;;585^10.99.1.67
 ;;520^10.132.96.24
 ;;564^10.134.10.116
 ;;623^10.134.140.38
 ;;629^10.131.90.19
 ;;635^10.135.56.118
 ;;667^10.129.131.82
 ;;519^10.146.252.103
 ;;501^10.144.252.224
 ;;644^10.148.253.60
 ;;442^10.152.21.79
 ;;756^10.147.252.224
 ;;649^10.149.252.225
 ;;554^10.153.5.154
 ;;436^10.154.132.68
 ;;678^10.150.253.218
 ;;575^10.155.134.45
 ;;654^10.172.25.11
 ;;640^10.168.99.38
 ;;459^10.170.100.74
 ;;612^10.173.19.113
 ;;666^10.152.183.178
 ;;531^10.167.138.66
 ;;648^10.165.50.99
 ;;663^10.161.5.50
 ;;653^10.166.130.147
 ;;668^10.163.14.34
 ;;463^10.162.140.63
 ;;687^10.163.144.27
 ;;692^10.167.4.52
 ;;358^10.171.253.13
 ;;570^10.171.67.160
 ;;662^10.174.1.79
 ;;605^10.177.118.81
 ;;593^10.176.50.24
 ;;618^10.104.10.89
 ;;ALBANY^10.1.19.150
 ;;600^10.179.99.94
 ;;ALBANY CS LAB^10.1.19.155
 ;;SILVER SPRING^10.2.29.172
 ;;664^10.178.10.73
 ;;691^10.180.1.48
 ;;508^10.58.239.74
 ;;HDR AAC^10.224.132.23
 ;;HDR AAC^10.224.132.28
 ;;AAC^10.224.151.133
 ;;AAC^10.224.151.153
 ;;BAY PINES OIFO^10.4.229.88
 ;;HINES OIFO^10.3.21.43
 ;;BIRMINGHAM OIFO^10.4.21.25
 ;;SALT LAKE OIFO^10.5.21.86
 ;;BAY PINES OIFO IV&V TEST LAB^10.4.229.85
 ;;HINES OIFO EMC DATA CENTER^10.3.21.48
 ;;HAC^10.6.21.42
 ;;HAC^10.191.10.152
 ;;IE Team - Dev & Test^10.4.229.90
 ;;EMC Data Center^10.3.21.53
 ;;IE Team - Dev & Test^10.6.21.50
 ;;MPI^10.224.151.138
 ;;CMOP^10.189.77.163
 ;;CMOP^10.189.101.157
 ;;CMOP^10.189.1.17
 ;;CMOP^10.189.61.94
 ;;636^10.114.5.4
 ;;CMOP^10.189.101.34
 ;;CMOP^10.189.77.74
 ;;CMOP^10.189.37.38
 ;;549^10.138.65.55
 ;;ARC^10.191.1.58
 ;;PLANO TEST SERVER^10.6.208.19
 ;;541^10.83.59.125
 ;;END
