IBATEI1 ;ALB/BGA-  TRANSFER PRICING BACKGROUND JOB ; 20-MAR-99 
 ;;2.0;INTEGRATED BILLING;**115**;21-MAR-94
 ;; Per VHA Directive 10-93-142, this routine should not be modified
 ;
BACKGRD ; This is the back ground job that monitors all the entries in 351.61
 ; If the entry is complete we check to see if there is a closed entry
 ; in PTF if there is we price the claim and change the status of
 ; the entry to priced.
 ;
 ; do prosthetics first
 D ^IBATER
 ;
 N IBI,IBREC,IBIAT,IBREST,IBPTF,IBTDFN,IBREC,IBDISHG,IBDPM,IBRECN,IBFINDRT,IBTFILE
 I '$P($G(^IBE(350.9,1,10)),"^",2) Q  ; transfer pricing turned off
 S IBREC="^IBAT(351.61,"_"""AF"""_","_"""C"""_")"
 F  S IBREC=$Q(@IBREC) Q:IBREC=""!($P(IBREC,",",3)'="""C""")  D
 . S IBIAT=$P($P(IBREC,",",4),")")
 . S IBRECN=$G(^IBAT(351.61,IBIAT,0))
 . S IBTDFN=$P(IBRECN,U,2)
 . S IBPTF=$P($G(^IBAT(351.61,+IBIAT,1)),U,7) Q:'IBPTF  ;ien ptf
 . S IBDISHG=$P($G(^IBAT(351.61,+IBIAT,1)),U,8) ; ien 405 discharge date Q:'IBIDSHG
 . S IBDPM=$P($G(^DGPM(+IBDISHG,0)),U,14) ; pointer to the parent movement
 . Q:IBDPM<1  ; No Movement Found
 . ; Inorder to price we need to have a closed PTF
 . I $P($G(^DGPT(IBPTF,0)),U,6)<1 Q
 . ; Pass in PTF=IBPTF ; ien DGPM (parent) ; DFN
 . S IBFINDRT=$$FINDRT^IBATEI(IBPTF,IBDPM,IBTDFN)
 . Q:'$P(IBFINDRT,U)
 . I $P(IBFINDRT,U,3)="B" D  Q
 . . ; case of bedsection pass in ien 351.61,"0" for drg,  the value of bed section charge
 . . S IBTFILE=$$INPT^IBATFILE(IBIAT,0,$P(IBFINDRT,U,2),"","","","")
 . E  D
 . . ; pass in ien 351.61,ien drg,drg value,los,high trim,outlier days,outlier rate
 . . S IBTFILE=$$INPT^IBATFILE(IBIAT,$P(IBFINDRT,U,3),$P(IBFINDRT,U,2),$P(IBFINDRT,U,4),$P(IBFINDRT,U,5),$P(IBFINDRT,U,6),$P(IBFINDRT,U,7))
 Q
