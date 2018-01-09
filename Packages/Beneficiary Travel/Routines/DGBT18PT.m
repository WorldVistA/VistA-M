DGBT18PT ;ALB/RAM - POST-INSTALL DGBT*1.0*18 ; 9/10/10 9:22Am
 ;;1.0;Beneficiary Travel;**18**;September 25, 2001;Build 15
 ;;Check for updated X-REFS (Fields: 21,22,25,26) used in Input Templates
 ;;
 Q
POST ;Post init
 N DGBTFLD,DGBTMFLD,DGBTOUT,DGBTF
 D TEMPL
 Q
 ;
TEMPL ;Determine templates on the FILE file to be compiled.
 N DGBTG,DGBTFIELD,DGBTNF,DGBTFILE,DGBTCNT
 D BMES^XPDUTL("Beginning to compile templates on the BENEFICIARY TRAVEL CLAIM (#392) file.")
 ;
 S DGBTNF="21,22,25,26",DGBTFILE=392,DGBTFIELD="",DGBTCNT=1
 F  S DGBTFIELD=$P(DGBTNF,",",DGBTCNT) Q:DGBTFIELD=""  D LOOP(DGBTFIELD,DGBTFILE) S DGBTCNT=DGBTCNT+1
 W !!
 S (DGBTX,DGBTY)=""
 D BMES^XPDUTL("The following routine namespace compiled:")
 F  S DGBTX=$O(DGBTCF(DGBTX)) Q:DGBTX=""  S DGBTY=$G(DGBTY)+1 S PRINT(DGBTY)=" "_DGBTX_"*"
 ;
 D MES^XPDUTL(.PRINT)
 K DGBTX,DGBTY,PRINT,DGBTCF
 Q
LOOP(DGBTFIELD,DGBTFILE) ;Compile templates.
 N DGBTG,DGBTTEMP,DGBTTEMPN,DGBTX,DGBTY,DGBTDM,DGBTTYPE
 F DGBTG="^DIE","^DIPT" D
 . S DGBTTYPE="Input" S:DGBTG="^DIPT" TYPE="Print"
 . I $D(@DGBTG@("AF",DGBTFILE,DGBTFIELD)) D
 .. S DGBTTEMP=0
 .. F  S DGBTTEMP=$O(@DGBTG@("AF",DGBTFILE,DGBTFIELD,DGBTTEMP)) Q:'DGBTTEMP  DO
 ... S DGBTTEMPN=$P($G(@DGBTG@(DGBTTEMP,0)),"^",1)
 ... I DGBTTEMPN="" D BMES^XPDUTL("Could not compile template "_DGBTTEMPN_$C(13,10)_"Please review!") Q
 ... S DGBTX=$P($G(@DGBTG@(DGBTTEMP,"ROUOLD")),"^")
 ... I DGBTX=""&($D(@DGBTG@(DGBTTEMP,"ROU"))'=0) D BMES^XPDUTL("Could not find routine for template "_DGBTTEMPN_$C(13,10)_"Please review!") Q
 ... I DGBTX=""&($D(@DGBTG@(DGBTTEMP,"ROU"))=0) Q
 ... W !,"Field: "_DGBTFIELD,!
 ... W !,DGBTTYPE," Template "_DGBTTEMPN_" needs to be compiled.",!
 ... I $D(DGBTCF(DGBTX)) Q  ;already compiled
 ... S DGBTCF(DGBTX)="" ;  remember the template was compiled
 ... S DGBTY=DGBTTEMP ;  set up the call for FileMan
 ... S DGBTDM=$$ROUSIZE^DILF
 ... I DGBTG="^DIE" D BMES^XPDUTL(" "),BMES^XPDUTL("   Compiling Input Templates") D EN^DIEZ Q
 ... I DGBTG="^DIPT" D BMES^XPDUTL(" "),BMES^XPDUTL("   Compiling Print Templates") D EN^DIPZ Q
 Q
 ;
 ;
