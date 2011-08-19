PXICLN9B ;ISL/dee - Cleanup routine for PX*1.0*9 ;11/8/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**9**;Aug 12, 1996
 ;
CLEANUP ;
 N PXICLN9 S PXICLN9=1 ;Flag that this job is running.
 N PXIVSIT,PXIVDT,PXICPT,PXIFILE,PXIVFILE,PXIVIEN,PXICNT
 N PXINODE,VSIT,PXINVSIT,PXITVSIT,PXIDEL
 N PXITDUP,PXITCNT,PXITNODE
 N PXISOR,PXIPKG,PXIHLOC,PXIOE
 ;
 ;Set up package and source for Rad and Lab
 S PXISOR(1)=$$SOURCE^PXAPIUTL("RAD/NUC MED")
 S PXISOR(2)=$$SOURCE^PXAPIUTL("LAB DATA")
 S PXIPKG(1)=$$PKG2IEN^VSIT("RA")
 S PXIPKG(2)=$$PKG2IEN^VSIT("LR")
 S PXIPKG(0)="~"_PXIPKG(1)_"~"_PXIPKG(2)_"~"
 ;
 ;get clinic for lab data
 S PXIHLOC(2)=+$G(^LAB(69.9,1,.8))
 ;
 I $D(^TMP("PXICLN9")) D
 . ;save data from where tasked errored out
 . K ^TMP("PXK",$J)
 . M ^TMP("PXK",$J)=^TMP("PXICLN9")
 . K ^TMP("PXICLN9")
 . D EN1^PXKMAIN
 . K ^TMP("PXK",$J)
 . D EVENT^PXKMAIN
 ;
 ;Where to start?
 S PXIVSIT=+$G(^PX(815,1,"PATCH"))
 I PXIVSIT<1 D
 . S PXIVSIT=$O(^AUPNVSIT("A"),-1)
 . I PXIVSIT>0 S PXIVSIT=PXIVSIT+1
 . E  S PXIVSIT=0
 . S $P(^PX(815,1,"PATCH"),"^",1)=PXIVSIT
 ;
 ;*R "Visit ien: ",PXIVSIT ;*
 ;*D  ;*
 F  S PXIVSIT=$O(^AUPNVSIT(PXIVSIT),-1) Q:'PXIVSIT  D
 . S PXICPT=$O(^AUPNVCPT("AD",PXIVSIT,0))
 . S PXIPRV=$O(^AUPNVPRV("AD",PXIVSIT,0))
 . I PXICPT S PXIPKG=$P($G(^AUPNVCPT(+PXICPT,812)),"^",2)
 . E  S PXIPKG=$P($G(^AUPNVPRV(+PXIPRV,812)),"^",2)
 . ;
 . ;Rad or Lab ?
 . I (PXICPT!PXIPRV),PXIPKG(0)[("~"_PXIPKG_"~") D
 .. K ^TMP("PXICLN9")
 .. ;
 .. ;Copy visit
 .. S PXINODE=""
 .. F  S PXINODE=$O(^AUPNVSIT(PXIVSIT,PXINODE)) Q:PXINODE=""  D
 ... S ^TMP("PXICLN9","VST",1,PXINODE,"AFTER")=^AUPNVSIT(PXIVSIT,PXINODE)
 ... S ^TMP("PXICLN9","VST",1,PXINODE,"BEFORE")=""
 .. S ^TMP("PXICLN9","VST",1,"IEN")=""
 .. ;Set sum stuff need by PXK
 .. S $P(^TMP("PXICLN9","VST",1,150,"AFTER"),"^",3)="A"
 .. S $P(^TMP("PXICLN9","VST",1,0,"AFTER"),"^",8)=""
 .. S ^TMP("PXICLN9","PKG")=PXIPKG
 .. ;
 .. ;Rad?
 .. I PXIPKG(1)=PXIPKG D
 ... S ^TMP("PXICLN9","SOR")=PXISOR(1)
 ... S $P(^TMP("PXICLN9","VST",1,812,"AFTER"),"^",3)=PXISOR(1)
 ... S PXISOR=PXISOR(1)
 ... S PXIHLOC=$P($$RADLOC($P(^TMP("PXICLN9","VST",1,0,"AFTER"),"^",5),$P(^TMP("PXICLN9","VST",1,0,"AFTER"),"^",1)),"^",2)
 .. ;Lab?
 .. E  D
 ... S ^TMP("PXICLN9","SOR")=PXISOR(2)
 ... S $P(^TMP("PXICLN9","VST",1,812,"AFTER"),"^",3)=PXISOR(2)
 ... S PXISOR=PXISOR(2)
 ... S PXIHLOC=PXIHLOC(2)
 .. ;
 .. ;check if the hospital location was ok if it is see if visit needs
 .. ;edit and quit
 .. I PXIHLOC>0,$P(^TMP("PXICLN9","VST",1,0,"AFTER"),"^",22)=PXIHLOC D  Q
 ... K VSIT
 ... I $P(^TMP("PXICLN9","VST",1,0,"AFTER"),"^",7)'="X" S VSIT("SVC")="X"
 ... I $P(^TMP("PXICLN9","VST",1,150,"AFTER"),"^",3)'="A" S VSIT("PRI")="A"
 ... I $P(^TMP("PXICLN9","VST",1,812,"AFTER"),"^",3)'=PXISOR S VSIT("SOR")=PXISOR
 ... Q:'$D(VSIT) 
 ... S VSIT("IEN")=PXIVSIT
 ... D UPD^VSIT
 .. ;
 .. S:PXIHLOC>0 $P(^TMP("PXICLN9","VST",1,0,"AFTER"),"^",22)=PXIHLOC
 .. ;
 .. ;Copy v-files pointing to visit
 .. ; (do not care about the stop code visit will just delete them)
 .. F PXIFILE="CPT","IMM","PED","POV","PRV","SK","TRT","HF","XAM" D
 ... S PXIVFILE="^AUPNV"_PXIFILE
 ... S PXIVIEN=0
 ... F PXICNT=1:1 S PXIVIEN=$O(@PXIVFILE@("AD",PXIVSIT,PXIVIEN)) Q:'PXIVIEN  D
 .... ;
 .... ;If this is Lab and is a even numbered duplicate CPT then do not save it
 .... I PXIFILE="CPT",PXIPKG(2)=PXIPKG D  Q:PXITDUP=1
 ..... ;check set
 ..... S PXITDUP=0
 ..... S PXITCNT=""
 ..... F  S PXITCNT=$O(^TMP("PXICLN9","CPT",PXITCNT)) Q:'PXITCNT  D  Q:PXITDUP
 ...... S PXITNODE=""
 ...... F  S PXITNODE=$O(^TMP("PXICLN9","CPT",PXITCNT,PXITNODE)) Q:PXITNODE'=+PXITNODE  D  Q:PXITDUP=-1
 ....... I $P(^TMP("PXICLN9","CPT",PXITCNT,PXITNODE,"AFTER"),"^",1,15)=$P($G(^AUPNVCPT(PXIVIEN,PXITNODE)),"^",1,15) S PXITDUP=1
 ....... E  S PXITDUP=-1
 ..... I PXITDUP=1 D
 ...... S PXDUPCPT(PXITCNT)=$G(PXDUPCPT(PXITCNT))+1
 ...... I '(PXDUPCPT(PXITCNT)#2) S $P(^TMP("PXICLN9","CPT",PXITCNT,0,"AFTER"),"^",16)=$P(^TMP("PXICLN9","CPT",PXITCNT,0,"AFTER"),"^",16)+$P($G(^AUPNVCPT(PXIVIEN,0)),"^",16)
 .... ;
 .... ;Copy a v-file entry
 .... S PXINODE=""
 .... F  S PXINODE=$O(@PXIVFILE@(PXIVIEN,PXINODE)) Q:PXINODE=""  D:PXINODE'=801
 ..... S ^TMP("PXICLN9",PXIFILE,PXICNT,PXINODE,"AFTER")=@PXIVFILE@(PXIVIEN,PXINODE)
 ..... S ^TMP("PXICLN9",PXIFILE,PXICNT,PXINODE,"BEFORE")=""
 .... S ^TMP("PXICLN9",PXIFILE,PXICNT,"IEN")=""
 .... ;
 .... ;Now fix any fields
 .... S:$P($G(^TMP("PXICLN9",PXIFILE,PXICNT,812,"AFTER")),"^",3)="" $P(^TMP("PXICLN9",PXIFILE,PXICNT,812,"AFTER"),"^",3)=PXISOR
 .. ;
 .. ;Process
 .. ;
 .. ;delete old data
 .. S PXIDEL=$$DELVFILE^PXAPIDEL("ALL",PXIVSIT,"","","","","")
 .. ;
 .. ;save data
 .. K ^TMP("PXK",$J)
 .. M ^TMP("PXK",$J)=^TMP("PXICLN9")
 .. K ^TMP("PXICLN9")
 .. D EN1^PXKMAIN
 .. S PXINVSIT=^TMP("PXK",$J,"VST",1,"IEN")
 .. ;fix 801 nodes? no they are ok
 .. D EVENT^PXKMAIN
 .. ;
 .. ;if the new visit is the same visit as the old visit then done
 .. Q:PXIVSIT=PXINVSIT
 .. ;
 .. ;if there is a new visit then assume all worked
 .. I PXINVSIT>0 D
 ... ;
 ... ;fix pointers from Rad and IB
 ... N PXIRA,PXIIBT,PXIFDA,PXIDIERR
 ... S (PXIRA(1),PXIIBT)=0
 ... F  S PXIRA(1)=$O(^RADPT("AVSIT",PXIVSIT,PXIRA(1))) Q:'PXIRA(1)  D
 .... S PXIRA(2)=0
 .... F  S PXIRA(2)=$O(^RADPT("AVSIT",PXIVSIT,PXIRA(1),PXIRA(2))) Q:'PXIRA(2)  D
 ..... S PXIRA(3)=0
 ..... F  S PXIRA(3)=$O(^RADPT("AVSIT",PXIVSIT,PXIRA(1),PXIRA(2),PXIRA(3))) Q:'PXIRA(3)  D
 ...... I PXIRA(1)>0,PXIRA(2)>0,PXIRA(3)>0 D
 ....... S PXIRA=PXIRA(3)_","_PXIRA(2)_","_PXIRA(1)_","
 ....... S PXIFDA(70.03,PXIRA,27)=PXINVSIT
 ... F  S PXIIBT=$O(^IBT(356,"AVSIT",PXIVSIT,PXIIBT)) Q:'PXIIBT  D
 .... I PXIIBT>0 D
 ..... S PXIIBT=PXIIBT_","
 ..... S PXIFDA(356,PXIIBT,.03)=PXINVSIT
 ... I $D(PXIFDA) D FILE^DIE("","PXIFDA","PXIDIERR")
 .. ;
 .. ;if the visit was not deleted try again
 .. I PXIDEL<1 D
 ... ;make sure that there are no extra Outpatient Encounter entries
 ... S PXIOE=0
 ... F  S PXIOE=$O(^SCE("AVSIT",PXIVSIT,PXIOE)) Q:'PXIOE  D EN^SDCODEL(PXIOE,0)
 ... S PXIDEL=$$KILL^VSITKIL(PXIVSIT)
 ... I PXIDEL>0 D
 .... ;change it to a stop visit
 .... K VSIT
 .... S VSIT("PRI")="S"
 .... S VSIT("IEN")=PXIVSIT
 .... D UPD^VSIT
 .... ;there was some problem deleting this one save it
 .... S ^XTMP("PXICLN9",$J,PXIVST)=PXIDEL
 . ;
 . ;Check the encounter type
 . I $P($G(^AUPNVSIT(PXIVSIT,150)),"^",3)="O" D
 .. Q:$D(^VSIT(150.1,"B",+$P($G(^DIC(40.7,+$P($G(^AUPNVSIT(PXIVSIT,0)),"^",8),0)),"^",2)))
 .. ;If it is "O" and it should not be, change it to "P"
 .. K VSIT
 .. I $P($G(^AUPNVSIT(PXIVSIT,812)),"^",3)="" D
 ... I PXICPT,$P($G(^AUPNVCPT(PXICPT,812)),"^",3)]"" S VSIT("SOR")=$P($G(^AUPNVCPT(PXICPT,812)),"^",3)
 ... E  I PXIPRV,$P($G(^AUPNVPRV(PXIPRV,812)),"^",3)]"" S VSIT("SOR")=$P($G(^AUPNVPRV(PXIPRV,812)),"^",3)
 .. S VSIT("PRI")="P"
 .. S VSIT("SVC")="A"
 .. I +$$IP^VSITCK1(+$G(^AUPNVSIT(PXIVSIT,0)),$P($G(^AUPNVSIT(PXIVSIT,0)),"^",5)) S VSIT("SVC")="I"
 .. S VSIT("IEN")=PXIVSIT
 .. D UPD^VSIT
 . ;
 . E  I $P($G(^AUPNVSIT(PXIVSIT,150)),"^",3)="P" D
 .. Q:'$D(^VSIT(150.1,"B",+$P($G(^DIC(40.7,+$P($G(^AUPNVSIT(PXIVSIT,0)),"^",8),0)),"^",2)))
 .. ;If it is "P" and it should not be, change it to "O"
 .. K VSIT
 .. I $P($G(^AUPNVSIT(PXIVSIT,812)),"^",3)="" D
 ... I PXICPT,$P($G(^AUPNVCPT(PXICPT,812)),"^",3)]"" S VSIT("SOR")=$P($G(^AUPNVCPT(PXICPT,812)),"^",3)
 ... E  I PXIPRV,$P($G(^AUPNVPRV(PXIPRV,812)),"^",3)]"" S VSIT("SOR")=$P($G(^AUPNVPRV(PXIPRV,812)),"^",3)
 .. S VSIT("PRI")="O"
 .. S VSIT("SVC")="X"
 .. I +$$IP^VSITCK1(+$G(^AUPNVSIT(PXIVSIT,0)),$P($G(^AUPNVSIT(PXIVSIT,0)),"^",5)) S VSIT("SVC")="D"
 .. S VSIT("IEN")=PXIVSIT
 .. D UPD^VSIT
 . S $P(^PX(815,1,"PATCH"),"^",1)=PXIVSIT
 K ^TMP("PXICLN9"),^TMP("PXK",$J)
 Q
 ;
RADNUC ;CAH/HIRMFO;for PCE data clean-up ;10/7/96  09:42
 ;
RADLOC(DFN,PXRADT) ;Returns Hosp Loc of Rad/Nuc Med exam
 ;Input:
 ;  DFN = Patient file #2 internal entry number
 ;  PXRADT = Rad exam dt/time in internal FileMan format
 ;  Sample input:  (6552,2961015.0915)
 ;Output:
 ;  If successful -
 ;       Imaging Loc name ^ pointer to file 44
 ;       Sample output:  X-RAY AREA B^35
 ;
 ;  If unsuccessful (exam or Imaging loc missing, or file 44
 ;       entry deleted, or patient does not exist in Rad/NM Patient
 ;       file #70) - 0
 ;
 N X,PXRA0,PXRADTI,PXRALOC,PXRALOC1,PXRALOC2
 I 'DFN Q 0
 I 'PXRADT Q 0
 I '$D(^RADPT(DFN)) Q 0  ;patient doesn't exist in file #70
 S PXRADTI=9999999.9999-PXRADT ;Convert exam dt/t to subfile ien
 S PXRA0=$G(^RADPT(DFN,"DT",PXRADTI,0)) I '$L(PXRA0) Q 0  ;if no such rad/nuc med visit, fail
 S PXRALOC=$P(PXRA0,"^",4) I 'PXRALOC Q 0  ;if no imaging loc, fail
 S PXRALOC1=$P(^RA(79.1,+PXRALOC,0),"^",1) I 'PXRALOC1 Q 0  ;if dangling pointer - file 44 entry deleted? fail
 I '$D(^SC(PXRALOC1)) Q 0  ;File 44 entry deleted?  fail
 S PXRALOC2=$P($G(^SC(PXRALOC1,0)),"^",1)
 Q PXRALOC2_"^"_PXRALOC1
 ;
