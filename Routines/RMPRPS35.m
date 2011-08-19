RMPRPS35 ;HINCIO/ODJ - HCPCS Update Utilities ; 3/25/04 12:27pm
 ;;3.0;PROSTHETICS;**58,69,76,77,84**,FEB 09,1996
 Q
 ;
 ; RVD 2/12/02 patch #76  - replace a list of deactivated for 2003 HCPCS
 ;
 ; RVD 4/25/02 patch #69  - replace a list of deactivated HCPCS.
 ;                          files (661.1 and 661.3)
 ; RVD patch #77 - Convert old HCPCS to new/replacement HCPCS in PIP.
 ;               - old HCPCS not included in patch #76
 ;               - Remove inactive flag.
 ;
 ; AAC 3/26/04 - Patch 84: Convert old HCPCS to new/replacement HCPCS in PIP.
 ;               Replace all CPT Codes with pointer 104840 - code A9900 begin with 1/1/04
 ;               Update all Modifier codes with null
 ;
 ; HCPCD - Change HCPCS code in files 660, 664, 664.1, 665, 665.72
 ;                                    661.2 and 661.3
 ;         Only to be run if users off the system
 ;         Used where the same HCPCS code has duplicate records.
 ; Inputs:
 ;    RMPRHPF - IEN of HCPCS to delete
 ;    RMPRHPT - IEN of HCPCS to copy deleted HCPCS to
 ;
HCPCD(RMPRHPF,RMPRHPT) ;
 N RMPRI,RMPRFDA,RMPRFME,RMPRIEN,RMPRS,RMPR65P,RMPRJ,RMPRPTP
 N RMPRO1,RMPRO2,RMPRO3,RMPRO4,RMPR641P,RMPR64P,X,Y,DA
 ;
 ; Start with file 660 using the H x-ref.
 S RMPRI=""
 F  S RMPRI=$O(^RMPR(660,"H",RMPRHPF,RMPRI)) Q:RMPRI=""  D
 . ;
 . ; Get pointer to 665 and update HCPCS multiples
 . S RMPR65P=$P($G(^RMPR(660,RMPRI,0)),"^",2)
 . S RMHCIT=$P($G(^RMPR(660,RMPRI,2)),"^",1)
 . I RMPR65P'="" D
 .. ;
 .. ; Update 665.194 multiple
 .. Q:'$D(^RMPR(665,RMPR65P,0))
 .. S RMPRPTP=$P(^RMPR(665,RMPR65P,0),"^",1)
 .. S RMPRJ=0
 .. F  S RMPRJ=$O(^RMPR(665,RMPR65P,"RMPOC",RMPRJ)) Q:'RMPRJ  D
 ... Q:$P($G(^RMPR(665,RMPR65P,"RMPOC",RMPRJ,0)),"^",7)'=RMPRHPF
 ... S RMPRIEN=RMPRJ_","_RMPR65P_","
 ... K RMPRFDA,RMPRFME
 ... S RMPRFDA(665.194,RMPRIEN,6)=RMPRHPT
 ... D FILE^DIE("","RMPRFDA","RMPRFME")
 ... Q
 .. ;
 .. ; Update 665.723191 multiple
 .. S RMPRO1=0
 .. F  S RMPRO1=$O(^RMPO(665.72,RMPRO1)) Q:'+RMPRO1  D
 ... S RMPRO2=0
 ... F  S RMPRO2=$O(^RMPO(665.72,RMPRO1,1,RMPRO2)) Q:'+RMPRO2  D
 .... S RMPRO3=0
 .... F  S RMPRO3=$O(^RMPO(665.72,RMPRO1,1,RMPRO2,1,RMPRO3)) Q:'+RMPRO3  D
 ..... I $D(^RMPO(665.72,RMPRO1,1,RMPRO2,1,RMPRO3,"V",RMPRPTP)) D
 ...... S RMPRO4=0
 ...... F  S RMPRO4=$O(^RMPO(665.72,RMPRO1,1,RMPRO2,1,RMPRO3,"V",RMPRPTP,1,RMPRO4)) Q:'+RMPRO4  D
 ....... Q:$P($G(^RMPO(665.72,RMPRO1,1,RMPRO2,1,RMPRO3,"V",RMPRPTP,1,RMPRO4,0)),"^",2)'=RMPRHPF
 ....... S RMPRIEN=RMPRO4_","_RMPRPTP_","_RMPRO3_","_RMPRO2_","_RMPRO1_","
 ....... K RMPRFME,RMPRFDA
 ....... S RMPRFDA(665.723191,RMPRIEN,2)=RMPRHPT
 ....... D FILE^DIE("","RMPRFDA","RMPRFME")
 ....... Q
 ...... Q
 ..... Q
 .... Q
 ... Q
 .. Q
 . ;
 . ; Update to 664.1 and 664 HCPCS multiples
 . S RMPRPTP=RMPR65P ;patient pointer
 . I RMPRPTP'="" D
 .. ;
 .. ; Update 664.16 multiple
 .. S RMPR641P=""
 .. F  S RMPR641P=$O(^RMPR(664.1,"D",RMPRPTP,RMPR641P)) Q:RMPR641P=""  D 
 ... S RMPRJ=0
 ... F  S RMPRJ=$O(^RMPR(664.1,RMPR641P,2,RMPRJ)) Q:'+RMPRJ  D
 .... Q:$P($G(^RMPR(664.1,RMPR641P,2,RMPRJ,2)),"^",1)'=RMPRHPF
 .... S RMPRIEN=RMPRJ_","_RMPR641P_","
 .... K RMPRFDA,RMPRFME
 .... S RMPRFDA(664.16,RMPRIEN,13)=RMPRHPT
 .... D FILE^DIE("","RMPRFDA","RMPRFME")
 .... Q
 ... Q
 .. Q
 . S RMPRPTP=RMPR65P ;patient pointer same as 665 pointer
 . I RMPRPTP'="" D
 .. ;
 .. ; Update 664.02 multiple
 .. S RMPR64P=""
 .. F  S RMPR64P=$O(^RMPR(664,"C",RMPRPTP,RMPR64P)) Q:RMPR64P=""  D
 ... S RMPRJ=0
 ... F  S RMPRJ=$O(^RMPR(664,RMPR64P,1,RMPRJ)) Q:'+RMPRJ  D
 .... Q:$P($G(^RMPR(664,RMPR64P,1,RMPRJ,0)),"^",16)'=RMPRHPF
 .... K RMPRFDA,RMPRFME
 .... S RMPRIEN=RMPRJ_","_RMPR64P_","
 .... S RMPRFDA(664.02,RMPRIEN,16)=RMPRHPT
 .... D FILE^DIE("","RMPRFDA","RMPRFME")
 .... Q
 ... Q
 .. Q
 . ;
 . ; finally update the 660 file
 . K RMPRFDA,RMPRFME
 . S RMPRIEN=RMPRI_","
 . S RMPRFDA(660,RMPRIEN,4.5)=RMPRHPT
 . S RMPRFDA(660,RMPRIEN,37)=RMPRHPT_"-"_$P(RMHCIT,"-",2)
 . D FILE^DIE("","RMPRFDA","RMPRFME")
 . Q
 ;
 ; Update PIP files 661.2 and 661.3
HCPCDP S RMPRI=""
 F  S RMPRI=$O(^RMPR(661.2,"D",RMPRHPF,RMPRI)) Q:RMPRI=""  D
 . K RMPRFDA,RMPRFME
 . S RMPRIEN=RMPRI_","
 . S RMPRFDA(661.2,RMPRIEN,3)=RMPRHPT
 . D FILE^DIE("","RMPRFDA","RMPRFME")
 . Q
 S RMPRI=0
 F  S RMPRI=$O(^RMPR(661.3,RMPRI)) Q:'+RMPRI  D
 . S RMPRJ=0
 . F  S RMPRJ=$O(^RMPR(661.3,RMPRI,1,RMPRJ)) Q:'+RMPRJ  D
 .. Q:$P($G(^RMPR(661.3,RMPRI,1,RMPRJ,0)),"^",1)'=RMPRHPF
 .. K RMPRFDA,RMPRFME
 .. S RMPRIEN=RMPRJ_","_RMPRI_","
 .. S RMPRFDA(661.31,RMPRIEN,.01)=RMPRHPT
 .. D FILE^DIE("","RMPRFDA","RMPRFME")
 .. Q
 . Q
 K RMPRFDA,RMPRFME
 S RMPRIEN=RMPRHPF_","
 S RMPRFDA(661.1,RMPRIEN,.01)="@"
 D FILE^DIE("","RMPRFDA","RMPRFME")
HCPCDX Q
 ;
 ; ITEM - move Item records from 661.1 from old to new HCPCS
 ;
 ; Inputs:
 ;   RMPRHPO - Old HCPCS code being replaced
 ;   RMPRHPN - New HCPCS code
 ;
ITEM(RMPRHPO,RMPRHPN) ;
 N RMPRHPOI,RMPRHPNI,RMPRJ,RMPRFDA,RMPRFME,RMPRIEN,X,Y,DA,RMPRIENA,RMPRK
 N RMPRL,RMPRS,RMPRITEM,RMPRIFLG,RML,RMPRIN,RMPRIO
 K ^TMP($J,"RM")
 S RMPRHPOI=$O(^RMPR(661.1,"B",RMPRHPO,"")) ;old HCPCS ien
 S RMPRHPNI=$O(^RMPR(661.1,"B",RMPRHPN,"")) ;new HCPCS ien
 Q:'$G(RMPRHPNI)!'$G(RMPRHPOI)
 G:$D(^RMPR(661.2,"D",RMPRHPNI)) ITEMX ;quit if Items already on new HCPCS and PIP.
 S RMPRIFLG=0
 I $P($G(^RMPR(661.1,RMPRHPOI,0)),"^",9)'="" S RMPRIFLG=1
 ;
 ; Loop on items and copy to new HCPCS
 S RML=0
 ;S RMPRIEN="+1,"_RMPRHPNI_","
 S (RMPRJ,RMPRN)=0
 I $D(^RMPR(661.1,RMPRHPNI,3,0)) S RMPRN=$P(^RMPR(661.1,RMPRHPNI,3,0),U,3)
 S RMPRIENA=RMPRN
 F  S RMPRJ=$O(^RMPR(661.1,RMPRHPOI,3,RMPRJ)) Q:'+RMPRJ  D
 . K RMPRFDA,RMPRFME,DIE
 . I RMPRN=0 S RMPRIENA=RMPRJ
 . I RMPRN>0 S RMPRIENA=RMPRIENA+1
 . S RML=RML+1
 . S RMPRIEN="+"_RML_","_RMPRHPNI_","
 . S RMPRFDA(661.12,RMPRIEN,.01)=$P(^RMPR(661.1,RMPRHPOI,3,RMPRJ,0),"^",1)
 . I $L(RMPRFDA(661.12,RMPRIEN,.01))>30 S RMPRFDA(661.12,RMPRIEN,.01)=$E(RMPRFDA(661.12,RMPRIEN,.01),1,30)
 .;don't create an entry if it's already been created.
 . Q:$D(^RMPR(661.1,RMPRHPNI,3,"B",RMPRFDA(661.12,RMPRIEN,.01)))
 . S ^TMP($J,"RM",RMPRJ)=RMPRIENA
 . D UPDATE^DIE("","RMPRFDA","RMPRIENA","RMPRFME")
 . Q
 ;
 ; Update 661.3 file
 S RMPRJ=""
 F  S RMPRJ=$O(^RMPR(661.3,"C",RMPRHPOI,RMPRJ)) Q:RMPRJ=""  D
 . S RMPRK=""
 . F  S RMPRK=$O(^RMPR(661.3,"C",RMPRHPOI,RMPRJ,RMPRK)) Q:RMPRK=""  D
 .. S RMPRL=0
 .. F  S RMPRL=$O(^RMPR(661.3,RMPRJ,1,RMPRK,1,RMPRL)) Q:'+RMPRL  D
 ... S RMPRS=^RMPR(661.3,RMPRJ,1,RMPRK,1,RMPRL,0)
 ... S RMPRITEM=$P(RMPRS,"^",1)
 ... S RMPRIO=$P(RMPRITEM,"-",2)
 ... Q:'$D(^TMP($J,"RM",RMPRIO))
 ... S RMPRIN=^TMP($J,"RM",RMPRIO)
 ... Q:'$G(RMPRIN)
 ... S $P(RMPRITEM,"-",1)=RMPRHPN
 ... S $P(RMPRITEM,"-",2)=RMPRIN
 ... S RMPRIEN=RMPRL_","_RMPRK_","_RMPRJ_","
 ... K RMPRFDA,RMPRFME
 ... S RMPRFDA(661.312,RMPRIEN,.01)=RMPRITEM
 ... D FILE^DIE("","RMPRFDA","RMPRFME")
 ... Q
 .. S RMPRIEN=RMPRK_","_RMPRJ_","
 .. K RMPRFDA,RMPRFME
 .. S RMPRFDA(661.31,RMPRIEN,.01)=RMPRHPNI
 .. D FILE^DIE("","RMPRFDA","RMPRFME")
 .. S RMPRIFLG=1
 .. Q
 . Q
 I RMPRIFLG D
 . K RMPRFDA,RMPRFME
 . S RMPRIEN=RMPRHPNI_","
 . S RMPRFDA(661.1,RMPRIEN,10)=1
 . D FILE^DIE("","RMPRFDA","RMPRFME")
 . Q
 ;
 ; Update PIP files 661.2
 S RMPRI=""
 F  S RMPRI=$O(^RMPR(661.2,"D",RMPRHPOI,RMPRI)) Q:RMPRI=""  D
 . Q:'$D(^RMPR(661.2,RMPRI,0))
 . S RMHCIT=$P(^RMPR(661.2,RMPRI,0),U,9)
 . K RMPRFDA,RMPRFME
 . S RMPRIEN=RMPRI_","
 . S RMPRFDA(661.2,RMPRIEN,3)=RMPRHPNI
 . S RMPRFDA(661.2,RMPRIEN,9)=RMPRHPN_"-"_$P(RMHCIT,"-",2)
 . D FILE^DIE("","RMPRFDA","RMPRFME")
 . Q
 ;
ITEMX Q
 ;
 ; PATCH58 - 
 ; 1 - Repoint duplicate HCPCS
 ; 2 - Copy item and current inventory to new HCPCS for specified list
 ; (patch 58 only)
PATCH58 N RMPRA,RMPRI
 I '$D(IO("Q")) D
 . W !!,"Repointing specified duplicate HCPCS...",!
 . Q
 D HCPCD(170,133) ;E0277
 I '$D(IO("Q")) D
 . W !!,"Repointing complete.",!
 . Q
 ;
 ;for next update, change RMPRA() local array to the HCPCS that need
 ;to be replaced.
PAT76 ; Set up array and replace HCPCS
 S U="^"
 I '$D(IO("Q")) D
 . W !!,"Replacing the following HCPCS...",!
 . Q
 ;patch #58 - replacement code
 ;K RMPRA
 ;S RMPRA(1)="K0182^A7018"
 ;S RMPRA(2)="K0269^E0572"
 S RMFLG61=""
 I '$D(^RMPR(661.6)),'$D(^RMPR(661.7)),'$D(^RMPR(661.9)) S RMFLG61=1 D CONV35^RMPRPS36
 ;F RMI=0:0 S RMI=$O(^RMPR(661.1,"RMPR",RMI)) Q:RMI'>0  D
 ;.S RMHCDA=^RMPR(661.1,"RMPR",RMI)
 ;.S RMHOLD=$P(RMHCDA,U,1),RMHNEW=$P(RMHCDA,U,2)
 ;.I '$D(IO("Q")) D
 ;..W !,RMHOLD," with ",RMHNEW
 ;.D ITEM(RMHOLD,RMHNEW)
 ;.Q
 I '$D(IO("Q")) D
 . W !!,"HCPCS replacement complete.",!
 . Q
 Q
CFLG ;remove calculation flag.
 W !!,"Removing the Calculation flag.....",!
 F RMPRI=1:1:66 S RMPRY=$P($T(FLG+RMPRI),";",4) Q:RMPRY'>0  D
 .S $P(^RMPR(661.1,RMPRY,0),U,8)=""
 W !!,"Done Removing Calculation flag!!!",!
 Q
FLG ;REMOVE calculation flag of the ff HCPCS:
 ;;E1038;3884
 ;;E1050;264
 ;;E1060;265
 ;;E1070;269
 ;;E1083;271
 ;;E1084;270
 ;;E1085;272
 ;;E1086;273
 ;;E1087;274
 ;;E1088;275
 ;;E1089;276
 ;;E1090;277
 ;;E1092;278
 ;;E1093;279
 ;;E1100;280
 ;;E1110;281
 ;;E1130;282
 ;;E1140;283
 ;;E1150;284
 ;;E1160;285
 ;;E1161;3885
 ;;E1170;286
 ;;E1171;287
 ;;E1172;288
 ;;E1180;289
 ;;E1190;290
 ;;E1195;291
 ;;E1200;292
 ;;E1210;293
 ;;E1211;294
 ;;E1212;295
 ;;E1213;296
 ;;E1220;297
 ;;E1221;298
 ;;E1222;299
 ;;E1223;300
 ;;E1224;301
 ;;E1225;302
 ;;E1226;303
 ;;E1227;304
 ;;E1228;305
 ;;E1230;306
 ;;E1240;307
 ;;E1250;308
 ;;E1260;309
 ;;E1270;310
 ;;E1280;311
 ;;E1285;312
 ;;E1290;313
 ;;E1295;314
 ;;E1296;315
 ;;E1297;316
 ;;E1298;317
 ;;K0001;339
 ;;K0002;340
 ;;K0003;341
 ;;K0004;342
 ;;K0005;343
 ;;K0006;344
 ;;K0007;345
 ;;K0009;347
 ;;K0010;348
 ;;K0011;349
 ;;K0012;350
 ;;K0014;352
 ;;END
