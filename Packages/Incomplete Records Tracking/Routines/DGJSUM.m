DGJSUM ;ALB/MAF - Interface routine with Discharge Summary Package - Jan 26 1993
 ;;1.0;Incomplete Records Tracking;;Jun 25, 2001
CHECK(DFN,DGJTDT,DGJPARM,DGJIRTDA,DGJT,DGJFLG,DGJTYP) ;Check to see if there is an IRT entry for a deficiency type.
 ;Input variables:  DFN
 ;                  DGJTDT  = Event Date
 ;                  DGJPARM =  Division Parameters
 ;                  DGJIRTDA= Incomplete Records IFN
 ;                  DGJT   = Array variables
 ;                      DGJT("DIV") = Division
 ;                      DGJT("AD#") = Admission IFN
 ;                      DGJT("WARD")= Ward
 ;                      DGJT("TS")  = Treating Specialty
 ;                      DGJT("ADDT") = Admission Date
 ;                  DGJFLG = returns '1' if new entry created
 ;       (optional) DGJTYP = Pointer to file #393.3 IRT Def. Type
 N DGJOUT
 S DGJPARM=$G(^DG(40.8,+$G(DGJT("DIV")),"DT"))
 Q:'+DGJPARM  ;If IRT not turned on
 S DGJTYP=$G(DGJTYP,+$O(^VAS(393.3,"B","DISCHARGE SUMMARY",0)))
 I DGJIRTDA]"",$D(^VAS(393,DGJIRTDA,0)) I '$D(^VAS(393,DGJIRTDA,"DT"))!($D(^VAS(393,DGJIRTDA,"DT"))&($P($G(^("DT")),"^",1)']"")) S DGJFLG=1 Q
 I DGJIRTDA]"",$D(^VAS(393,DGJIRTDA,0)) Q
 S DGJIRTDA=0 F  S DGJIRTDA=$O(^VAS(393,"B",DFN,DGJIRTDA)) Q:+DGJIRTDA'>0  D  I +$G(DGJOUT) Q
 .I $P($G(^VAS(393,DGJIRTDA,0)),"^",2)=DGJTYP,$P($G(^VAS(393,DGJIRTDA,0)),"^",4)=$G(DGJT("AD#")) S DGJOUT=1 Q
 I 'DGJIRTDA D ADD Q
 Q
ADD ;Create an IRT entry
 N DIC,DLAYGO,DR,DIE,DGJT9,DGJT10,DGJTSP,DGJTSV,DGJX,DGJY,DGJTEV,DGJTWARD
 S DGJTSV=$S($G(DGJT("WARD"))]"":$P(^DIC(42,+$G(DGJT("WARD")),0),"^",3),1:"")
 S:DGJTSV']"" DGJTSV=0 S DGJTSV=$S($D(^DG(393.1,"AC",DGJTSV)):$O(^(DGJTSV,0)),1:"") I DGJTSV']"" S DGJTSV=$O(^DG(393.1,"AC",0,0))
 S DGJTSP=$O(^DGPM("ATS",DFN,+$G(DGJT("AD#")),0)),DGJTSP=$O(^(+DGJTSP,0)),DGJTSP=$O(^(+DGJTSP,0)),DGJTSP=$S($D(^DGPM(+DGJTSP,0)):^(0),1:"") ;last TS mvt
 S DGJX=8,DGJY=2 D DOC S DGJT9=X,X=""
 S DGJT10="" I $P(DGJPARM,"^",3) S DGJX=19,DGJY=4 D DOC S DGJT10=X
 S DGJTEV=$S(DGJTDT]"":DGJTDT,1:$P(DGJT("ADDT"),"^",1)),DGJTWARD=$G(^DIC(42,$P($G(DGJT("WARD")),"^",1),44))
 S DIC="^VAS(393,",DLAYGO=393,DIC(0)="L",X=DFN D FILE^DICN
 S DGJIRTDA=+Y I +Y'>0 Q
 L +^VAS(393,+DGJIRTDA):1 I '$T Q
 S DR=".02////"_DGJTYP_";.03////"_DGJTEV_";.04////"_$G(DGJT("AD#"))_";.05////"_DGJTWARD_";.06////"_$G(DGJT("DIV"))_";.07////"_$P($G(DGJT("TS")),"^",1)_";.08////"_DGJTSV_";.09////"_DGJT9_";.1////"_DGJT10_";.12////"_DGJT9_";.13////1"
 S DIE="^VAS(393,",DA=DGJIRTDA D ^DIE
 L -^VAS(393,+DGJIRTDA)
 S DGJFLG=1 Q
EDIT(DGJIRTDA,DGJVDD,DGJVDB,DGJVDT,DGJVTB,DGJPARM) ;Edit an IRT file entry.
 L +^VAS(393,+DGJIRTDA):1 I '$T Q
 S DR="10.01////"_DGJVDD_";10.02////"_DGJVDB_";10.03////"_DGJVDT_";10.04///"_DGJVTB_";10.05///@;10.06///@;10.07///@;10.08///@"
 S DIE="^VAS(393,",DA=DGJIRTDA D ^DIE,STAT1
 L -^VAS(393,+DGJIRTDA)
 Q
DCSDEL(DGJIRTDA,DGJPARM) ;If DCS is Deleted, IRT Rec should just contain a stub
 L +^VAS(393,+DGJIRTDA):1 I '$T Q
 S DR="10.01///@;10.02///@;10.03///@;10.04///@;10.05///@;10.06///@;10.07///@;10.08///@"
 S DIE="^VAS(393,",DA=DGJIRTDA D ^DIE,STAT1
 L -^VAS(393,+DGJIRTDA)
 Q
SIGUP(DGJIRTDA,DGJDS,DGJSB,DGJDR,DGJRB,DGJPARM) ;Update Signed and Reviewed fields.
 L +^VAS(393,+DGJIRTDA):1 I '$T Q
 S DR="10.05////"_DGJDS_";10.06////"_DGJSB_";10.07////"_DGJDR_";10.08////"_DGJRB
 S DA=DGJIRTDA,DIE=393 D ^DIE,STAT1
 L -^VAS(393,+DGJIRTDA)
 Q
STAT1 ;check on the status of the report after a change has been made.
 N DGJNODE,DGJSTAT,DGJSTAT1
 S DGJNODE=$G(^VAS(393,DGJIRTDA,"DT"))
 I $P(DGJNODE,"^",1)']"" S DGJSTAT="INCOMPLETE" G STAT
 I $P(DGJNODE,"^",3)']"" S DGJSTAT="DICTATED" G STAT
 I $P(DGJNODE,"^",5)']"" S DGJSTAT="TRANSCRIBED" G STAT
 I $P(DGJPARM,"^",3)=0 S DGJSTAT="SIGNED NO REVIEW" G STAT
 I $P(DGJNODE,"^",7)']"" S DGJSTAT="SIGNED" G STAT
 I $P(DGJPARM,"^",3)=1 S DGJSTAT="REVIEWED"
STAT S DGJSTAT1=$O(^DG(393.2,"B",DGJSTAT,0)) S DIE="^VAS(393,",DA=DGJIRTDA,DR=".11////^S X=DGJSTAT1" D ^DIE K DR,DIE K DGJSTAT1
 Q
DOC ;provider resp.
 S X=$P(DGJPARM,"^",DGJY)
 S X=$S(X="A":$P(DGJTSP,"^",19),X="N":"",1:$P(DGJTSP,"^",8))
 Q
