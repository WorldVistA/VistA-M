YSCL149P ; HEC/hrubovcak - NCC Post-install;5 Dec 2019 17:21:16
 ;;5.01;MENTAL HEALTH;**149**;Dec 30, 1994;Build 72
 ;
 ; External reference to File 870 supported by DBIA 1496
 ; External reference to ^XLFDT supported by DBIA 10103
 ; External reference to ^XPDUTL supported by DBIA 10141
 ;
 ; 5 December 2019
 Q  ;NO Entry CALL POST To Configure HLO Link
 ;
POST ; Post-Install logic
 ;
 D DT^DICRW
 N YSDIC,YSFMERR,YSFMIEN,YSFMROOT,YSIENS,YSLLPTR
 N VDIFRTR,VDIFIP,VDIFDNS,VDIFPORT,VDIFTEST
 D MES^XPDUTL("Checking the YSCL-NCCC logical link.")
 D FIND^DIC(870,,,"X","YSCL-NCCC",,"B",,,"YSDIC","YSFMERR")  ; find the IEN
 S YSIENS=$G(YSDIC("DILIST",2,1))
 I '(YSIENS>0) D  Q  ; entry not found, something's wrong
 .  D BMES^XPDUTL("*** ERROR: The YSCL-NCCC logical link was not found. *** ")
 .  D MES^XPDUTL("Please contact the Clozapine Modernization Team.")
 ;
 S YSIENS=YSIENS_","  K YSDIC,YSFMERR
 ; look up HL LOWER LEVEL PROTOCOL
 D FIND^DIC(869.1,,,"X","TCP",,"B",,,"YSDIC","YSFMERR")
 S YSLLPTR=$G(YSDIC("DILIST",2,1))  ; lower level pointer
 S VDIFRTR=$$GETVDIFD()
 S VDIFIP=$P(VDIFRTR,"^",3)
 S VDIFDNS=$P(VDIFRTR,"^",2)
 S VDIFPORT=$P(VDIFRTR,"^",4)
 K YSDIC,YSFMERR
 S YSFMROOT(870,YSIENS,.08)=VDIFDNS ;;(#.08) DNS DOMAIN [8F]
 S YSFMROOT(870,YSIENS,2)=YSLLPTR ;    (#2) LLP TYPE [3P:869.1] 
 S YSFMROOT(870,YSIENS,400.01)=VDIFIP  ; (#400.01) TCP/IP ADDRESS [1F]
 S YSFMROOT(870,YSIENS,400.02)=VDIFPORT ;  (#400.02) TCP/IP PORT [2N]
 S YSFMROOT(870,YSIENS,400.03)="C" ; (#400.03) TCP/IP SERVICE TYPE [3S] - 'C' FOR CLIENT (SENDER)
 S YSFMROOT(870,YSIENS,400.08)=VDIFPORT ;  (#400.08) TCP/IP PORT (OPTIMIZED) [8N]
 D UPDATE^DIE("","YSFMROOT","YSFMIEN","YSFMERR")
 ;
 D BMES^XPDUTL($$HTE^XLFDT($H)_" > The YSCL-NCCC logical link was updated.")
 Q
 ;
GETVDIFD() ;Get VDIF IP, DNS, Port for current station
 N INC,TAGTXT,TEST,STN
 K DET S DET=0
 S STN=$P($$SITE^VASITE,"^",1)
 S TEST='$$PROD^XUPROD  ;Only Populate Prod
 F INC=1:1 S TAGTXT=$P($T(RTDATA+INC),";;",2) Q:TAGTXT=""!(DET)  D
 . Q:$P(TAGTXT,"^")'=STN
 . S DET=$P(TAGTXT,"^",1,4)
 I 'DET!TEST S DET="^^^"
 Q DET
 ;
RTDATA ;VDIF router details - Reference data for each site and which VDIF router to use
 ;;358^hc-vdif-r01-01.domain.ext^^7200
 ;;436^hc-vdif-r01-02.domain.ext^^7200
 ;;442^hc-vdif-r01-02.domain.ext^^7201
 ;;459^hc-vdif-r01-01.domain.ext^^7201
 ;;501^hc-vdif-r01-02.domain.ext^^7202
 ;;463^hc-vdif-r01-01.domain.ext^^7202
 ;;504^hc-vdif-r01-01.domain.ext^^7203
 ;;554^hc-vdif-r01-02.domain.ext^^7203
 ;;519^hc-vdif-r01-01.domain.ext^^7204
 ;;575^hc-vdif-r01-02.domain.ext^^7204
 ;;531^hc-vdif-r01-01.domain.ext^^7205
 ;;593^hc-vdif-r01-02.domain.ext^^7205
 ;;570^hc-vdif-r01-01.domain.ext^^7206
 ;;600^hc-vdif-r01-02.domain.ext^^7206
 ;;605^hc-vdif-r01-02.domain.ext^^7207
 ;;612^hc-vdif-r01-01.domain.ext^^7207
 ;;640^hc-vdif-r01-01.domain.ext^^7208
 ;;644^hc-vdif-r01-02.domain.ext^^7208
 ;;648^hc-vdif-r01-01.domain.ext^^7209
 ;;649^hc-vdif-r01-02.domain.ext^^7209
 ;;653^hc-vdif-r01-01.domain.ext^^7210
 ;;660^hc-vdif-r01-02.domain.ext^^7210
 ;;654^hc-vdif-r01-01.domain.ext^^7211
 ;;662^hc-vdif-r01-02.domain.ext^^7211
 ;;663^hc-vdif-r01-01.domain.ext^^7212
 ;;664^hc-vdif-r01-02.domain.ext^^7212
 ;;666^hc-vdif-r01-02.domain.ext^^7213
 ;;668^hc-vdif-r01-01.domain.ext^^7213
 ;;678^hc-vdif-r01-02.domain.ext^^7214
 ;;687^hc-vdif-r01-01.domain.ext^^7214
 ;;756^hc-vdif-r01-02.domain.ext^^7215
 ;;691^hc-vdif-r01-01.domain.ext^^7215
 ;;692^hc-vdif-r01-01.domain.ext^^7216
 ;;437^hc-vdif-r02-01.domain.ext^^7200
 ;;438^hc-vdif-r02-01.domain.ext^^7201
 ;;502^hc-vdif-r02-01.domain.ext^^7202
 ;;520^hc-vdif-r02-01.domain.ext^^7203
 ;;537^hc-vdif-r02-01.domain.ext^^7204
 ;;549^hc-vdif-r02-01.domain.ext^^7205
 ;;556^hc-vdif-r02-01.domain.ext^^7206
 ;;564^hc-vdif-r02-01.domain.ext^^7207
 ;;568^hc-vdif-r02-01.domain.ext^^7208
 ;;578^hc-vdif-r02-01.domain.ext^^7209
 ;;580^hc-vdif-r02-01.domain.ext^^7210
 ;;585^hc-vdif-r02-01.domain.ext^^7211
 ;;586^hc-vdif-r02-01.domain.ext^^7212
 ;;589^hc-vdif-r02-01.domain.ext^^7213
 ;;598^hc-vdif-r02-01.domain.ext^^7214
 ;;607^hc-vdif-r02-01.domain.ext^^7215
 ;;618^hc-vdif-r02-01.domain.ext^^7216
 ;;623^hc-vdif-r02-01.domain.ext^^7217
 ;;629^hc-vdif-r02-01.domain.ext^^7218
 ;;635^hc-vdif-r02-01.domain.ext^^7219
 ;;636^hc-vdif-r02-01.domain.ext^^7220
 ;;656^hc-vdif-r02-01.domain.ext^^7221
 ;;657^hc-vdif-r02-01.domain.ext^^7222
 ;;667^hc-vdif-r02-01.domain.ext^^7223
 ;;671^hc-vdif-r02-01.domain.ext^^7224
 ;;674^hc-vdif-r02-01.domain.ext^^7225
 ;;676^hc-vdif-r02-01.domain.ext^^7226
 ;;695^hc-vdif-r02-01.domain.ext^^7228
 ;;740^hc-vdif-r02-01.domain.ext^^7229
 ;;506^hc-vdif-r03-01.domain.ext^^7200
 ;;508^hc-vdif-r03-01.domain.ext^^7201
 ;;509^hc-vdif-r03-01.domain.ext^^7202
 ;;515^hc-vdif-r03-01.domain.ext^^7203
 ;;516^hc-vdif-r03-01.domain.ext^^7204
 ;;517^hc-vdif-r03-01.domain.ext^^7205
 ;;757^hc-vdif-r03-01.domain.ext^^7206
 ;;521^hc-vdif-r03-01.domain.ext^^7207
 ;;534^hc-vdif-r03-01.domain.ext^^7208
 ;;538^hc-vdif-r03-01.domain.ext^^7209
 ;;539^hc-vdif-r03-01.domain.ext^^7210
 ;;541^hc-vdif-r03-01.domain.ext^^7211
 ;;544^hc-vdif-r03-01.domain.ext^^7212
 ;;546^hc-vdif-r03-01.domain.ext^^7213
 ;;548^hc-vdif-r03-01.domain.ext^^7214
 ;;550^hc-vdif-r03-01.domain.ext^^7215
 ;;552^hc-vdif-r03-01.domain.ext^^7216
 ;;553^hc-vdif-r03-01.domain.ext^^7217
 ;;557^hc-vdif-r03-01.domain.ext^^7218
 ;;558^hc-vdif-r03-01.domain.ext^^7219
 ;;565^hc-vdif-r03-01.domain.ext^^7220
 ;;573^hc-vdif-r03-01.domain.ext^^7221
 ;;581^hc-vdif-r03-01.domain.ext^^7222
 ;;583^hc-vdif-r03-01.domain.ext^^7223
 ;;590^hc-vdif-r03-01.domain.ext^^7224
 ;;596^hc-vdif-r03-01.domain.ext^^7225
 ;;603^hc-vdif-r03-01.domain.ext^^7226
 ;;610^hc-vdif-r03-01.domain.ext^^7227
 ;;614^hc-vdif-r03-01.domain.ext^^7228
 ;;619^hc-vdif-r03-01.domain.ext^^7229
 ;;621^hc-vdif-r03-01.domain.ext^^7230
 ;;626^hc-vdif-r03-01.domain.ext^^7231
 ;;637^hc-vdif-r03-01.domain.ext^^7232
 ;;652^hc-vdif-r03-01.domain.ext^^7233
 ;;655^hc-vdif-r03-01.domain.ext^^7234
 ;;658^hc-vdif-r03-01.domain.ext^^7235
 ;;659^hc-vdif-r03-01.domain.ext^^7236
 ;;672^hc-vdif-r03-01.domain.ext^^7237
 ;;673^hc-vdif-r03-01.domain.ext^^7238
 ;;675^hc-vdif-r03-01.domain.ext^^7239
 ;;679^hc-vdif-r03-01.domain.ext^^7240
 ;;402^hc-vdif-r04-02.domain.ext^^7200
 ;;460^hc-vdif-r04-01.domain.ext^^7200
 ;;503^hc-vdif-r04-01.domain.ext^^7201
 ;;405^hc-vdif-r04-02.domain.ext^^7201
 ;;518^hc-vdif-r04-02.domain.ext^^7202
 ;;512^hc-vdif-r04-01.domain.ext^^7202
 ;;523^hc-vdif-r04-02.domain.ext^^7203
 ;;526^hc-vdif-r04-02.domain.ext^^7204
 ;;529^hc-vdif-r04-01.domain.ext^^7204
 ;;540^hc-vdif-r04-01.domain.ext^^7205
 ;;528^hc-vdif-r04-02.domain.ext^^7205
 ;;542^hc-vdif-r04-01.domain.ext^^7206
 ;;561^hc-vdif-r04-02.domain.ext^^7206
 ;;562^hc-vdif-r04-01.domain.ext^^7207
 ;;608^hc-vdif-r04-02.domain.ext^^7207
 ;;620^hc-vdif-r04-02.domain.ext^^7208
 ;;595^hc-vdif-r04-01.domain.ext^^7208
 ;;613^hc-vdif-r04-01.domain.ext^^7209
 ;;630^hc-vdif-r04-02.domain.ext^^7209
 ;;631^hc-vdif-r04-02.domain.ext^^7210
 ;;642^hc-vdif-r04-01.domain.ext^^7210
 ;;632^hc-vdif-r04-02.domain.ext^^7211
 ;;646^hc-vdif-r04-01.domain.ext^^7211
 ;;650^hc-vdif-r04-02.domain.ext^^7212
 ;;688^hc-vdif-r04-01.domain.ext^^7212
 ;;689^hc-vdif-r04-02.domain.ext^^7213
 ;;693^hc-vdif-r04-01.domain.ext^^7213
 ;;
 ;
 Q
