VSITVID ;ISL/dee - Computes the Visit Id ;4/17/97
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**76**;Aug 12, 1996
 ; Patch PX*1*76 changes the 2nd line of all VSIT* routines to reflect
 ; the incorporation of the module into PCE.  For historical reference,
 ; the old (VISIT TRACKING) 2nd line is included below to reference VSIT
 ; patches.
 ;
 ;;2.0;VISIT TRACKING**2**;;Aug 12, 1996
 Q
 ;
GETVID() ;Sets the VSIT("VID") node with the next unique Visit Id
 N LASTONE,LASTSEQ,SITE,LASTUSED,NEXTSEQ
 ;Lock parameters file
 L +^DIC(150.9,1,4):1800 E  Q -1
 ;Get the last one from parameters file
 S LASTONE=^DIC(150.9,1,4)
 S LASTSEQ=$P(LASTONE,"^",1)
 S SITE=$P(^VSIT(150.2,$P(LASTONE,"^",2),0),"^",2)
 ;Get the next one (call the function below)
 S NEXTSEQ=$$NEXT(LASTSEQ)
 ;Save new one in parameters file
 S $P(^DIC(150.9,1,4),"^",1)=NEXTSEQ
 L -^DIC(150.9,1,4)
 ;Combine the sequence number and the site to make the new Visit Id
 Q NEXTSEQ_"-"_SITE
 ;
NEXT(SEQNUMB) ;Pass in the last sequence number and returns the next unique number in the sequence 
 ;This routine adds one to a base 27 number
 N VSITSTR,VSITPLAC,VSITDIG
 ;Do not change this string (or the copy of it below in FIXVID):
 S VSITSTR="0123456789BCDFGHJKMNPQRTVWX0"
 S VSITPLAC=$L(SEQNUMB)
NEXTDIG S VSITDIG=$E(VSITSTR,$F(VSITSTR,$E(SEQNUMB,VSITPLAC)))
 S SEQNUMB=$E(SEQNUMB,0,VSITPLAC-1)_VSITDIG_$E(SEQNUMB,VSITPLAC+1,99)
 I VSITDIG=0 S VSITPLAC=VSITPLAC-1 S:VSITPLAC<1 SEQNUMB="0"_SEQNUMB,VSITPLAC=1 G NEXTDIG
 Q SEQNUMB
 ;
TEST ;This prints every 100,000 number in base 27 then base 10
 W !,"WARNING, This routine never quits!"
 S COUNT=0
 S NUM="0"
TESTNEXT S NUM=$$NEXT(NUM)
 S COUNT=COUNT+1
 I '(COUNT#100000) W !,NUM,"    ",COUNT Q
 G TESTNEXT
 K COUNT,NUM
 Q
 ;
FIXVID(VSITIEN) ;If the Visit ID is not valued then get a new id and store it
 ;Return:
 ;  -2        If called with a bad pointer to Visit
 ;  -1        If could not get a new Visit ID or store it.
 ;  Visit ID  If Visit has one or one was added.
 N VSITVID,VSITTEST
 Q:$G(VSITIEN)<1 -2
 Q:'($D(^AUPNVSIT(VSITIEN,0))#2) -2
 ;Test to see if current Visit ID is good.
 S VSITVID=$P($G(^AUPNVSIT(VSITIEN,150)),"^",1)
 ; check against the DD for the field
 D CHK^DIE(9000010,15001,"",VSITVID,.VSITTEST)
 ; it is bad if VSITTEST="^"
 I VSITTEST'="^" D  Q:VSITTEST'="^" VSITVID
 . ;Fileman said it was good now make sure value is valid
 . ;Do not change this string (it is the same as the one above):
 . I $TR($P(VSITVID,"-",1),"0123456789BCDFGHJKMNPQRTVWX0")'="" S VSITTEST="^"
 . E  I '$D(^VSIT(150.2,"D",$P(VSITVID,"-",2))) S VSITTEST="^"
 ;
 ;Need to get new Visit Id
 N VSIT
 S VSIT("VID")=$$GETVID ;            Get new Visit ID
 Q:VSIT("VID")=-1 -1 ;               Return -1 if can not get a Visit ID
 I VSITVID]"" D  ;                   Delete bad Visit ID if there is one
 . S $P(^AUPNVSIT(VSITIEN,150),"^",1)=""
 . K ^AUPNVSIT("VID",VSITVID,VSITIEN)
 S VSIT("IEN")=VSITIEN
 D UPD^VSIT ;                        Save new Visit ID
 I VSIT("VID")=$P($G(^AUPNVSIT(VSITIEN,150)),"^",1) Q VSIT("VID")
 Q -1
 ;
