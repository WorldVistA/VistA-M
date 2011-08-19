DGENL1 ;ALB/RMO,ISA/KWP,Zoltan,ALB/BRM,LBD,ERC,EG,CKN,BAJ - Patient Enrollment - Build List Area ; 8/1/08 1:12pm
 ;;5.3;Registration;**121,147,232,266,343,564,672,659,653,688**;Aug 13,1993;Build 29
 ;
EN(DGARY,DFN,DGENRIEN,DGCNT) ;Entry point to build list area
 ; for patient enrollment and patient enrollment history
 ; Input  -- DGARY    Global array subscript
 ;           DFN      Patient IEN
 ;           DGENRIEN Enrollment IEN
 ; Output -- DGCNT    Number of lines in the list
 N DGENCAT,DGENR,DGLINE
 I DGENRIEN,$$GET^DGENA(DGENRIEN,.DGENR) ;set-up enrollment array
 S DGENCAT=$$CATEGORY^DGENA4(,$G(DGENR("STATUS")))  ;enrollment category
 S DGENCAT=$$EXTERNAL^DILFD(27.15,.02,"",DGENCAT)
 S DGLINE=1,DGCNT=0
 D ENR(DGARY,DFN,.DGENR,.DGLINE,.DGCNT) ;enrollment
 D PF(DGARY,DFN,.DGENR,.DGLINE,.DGCNT) ;priority factors
 D HIS^DGENL2(DGARY,DFN,DGENRIEN,.DGLINE,.DGCNT) ;history
 Q
 ;
ENR(DGARY,DFN,DGENR,DGLINE,DGCNT) ;Enrollment 
 ; Input  -- DGARY    Global array subscript
 ;           DFN      Patient IEN
 ;           DGENR    Enrollment array
 ;           DGLINE   Line number
 ; Output -- DGCNT    Number of lines in the list
 N DGSTART
 ;
 S DGSTART=DGLINE ; starting line number
 D SET(DGARY,DGLINE,"Enrollment",31,IORVON,IORVOFF,,,,.DGCNT)
 ;
 ;Enrollment Date
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"Enrollment Date: "_$S($G(DGENR("DATE")):$$EXT^DGENU("DATE",DGENR("DATE")),1:""),11,,,,,,.DGCNT)
 ;
 ;
 ;Enrollment End Date
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"Enrollment End Date: "_$S($G(DGENR("END")):$$EXT^DGENU("END",DGENR("END")),1:""),7,,,,,,.DGCNT)
 ;
 ;Enrollment Application Date
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"Application Date: "_$S($G(DGENR("APP")):$$EXT^DGENU("APP",DGENR("APP")),1:""),10,,,,,,.DGCNT)
 ;
 ;Source
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"Source of Enrollment: "_$S($G(DGENR("SOURCE")):$$EXT^DGENU("SOURCE",DGENR("SOURCE")),1:""),6,,,,,,.DGCNT)
 ;
 ;Category
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"Enrollment Category: "_DGENCAT,7,IORVON,IORVOFF,,,,.DGCNT)
 ;
 ;Status
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"Enrollment Status: "_$S($G(DGENR("STATUS")):$$EXT^DGENU("STATUS",DGENR("STATUS")),1:""),9,,,,,,.DGCNT)
 ;
 ;Priority
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"Enrollment Priority: "_$S($G(DGENR("PRIORITY")):DGENR("PRIORITY"),1:"")_$S($G(DGENR("SUBGRP")):$$EXT^DGENU("SUBGRP",DGENR("SUBGRP")),1:""),7,,,,,,.DGCNT)
 ;
 ;
 ;Effective date
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"Effective Date: "_$S($G(DGENR("EFFDATE")):$$EXT^DGENU("EFFDATE",DGENR("EFFDATE")),1:""),12,,,,,,.DGCNT)
 ;
 ;Reason canceled/declined
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"",1,,,,,,.DGCNT)
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"Reason Canceled/Declined: "_$S($G(DGENR("REASON")):$$EXT^DGENU("REASON",DGENR("REASON")),1:""),2,,,,,,.DGCNT)
 ;
 ;Canceled/declined remarks
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"Canceled/Declined Remarks: "_$S($G(DGENR("REASON"))'="":$$EXT^DGENU("REMARKS",DGENR("REMARKS")),1:""),1,,,,,,.DGCNT)
 ;
 ;Entered by
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"",1,,,,,,.DGCNT)
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"Entered By: "_$S($G(DGENR("USER")):$$EXT^DGENU("USER",DGENR("USER")),1:""),16,,,,,,.DGCNT)
 ;
 ;Date/time entered
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"Date/Time Entered: "_$S($G(DGENR("DATETIME")):$$EXT^DGENU("DATETIME",DGENR("DATETIME")),1:""),9,,,,,,.DGCNT)
 ;
 ;Set line to start on next page
 F DGLINE=DGLINE+1:1:DGSTART+VALM("LINES") D SET(DGARY,DGLINE,"",1,,,,,,.DGCNT)
 Q
 ;
PF(DGARY,DFN,DGENR,DGLINE,DGCNT) ;Priority factors 
 ; Input  -- DGARY    Global array subscript
 ;           DFN      Patient IEN
 ;           DGENR    Enrollment array
 ;           DGLINE   Line number
 ; Output -- DGCNT    Number of lines in the list
 N DGSTART
 ;
 S DGSTART=DGLINE ; starting line number
 D SET(DGARY,DGLINE,"Priority Factors",31,IORVON,IORVOFF,,,,.DGCNT)
 ;
 ;POW
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"POW: "_$S($G(DGENR("ELIG","POW"))'="":$$EXT^DGENU("POW",DGENR("ELIG","POW")),1:""),19,,,,,,.DGCNT)
 ;
 ;Purple Heart - added for patch 343;brm;10/23/00
 N PHDAT
 S DGLINE=DGLINE+1
 S PHDAT=$$PHEART(DFN,$G(DGENRIEN),$G(DGENR("DATETIME")))
 D SET(DGARY,DGLINE,"Purple Hrt: "_$P(PHDAT,U),12,,,,,,.DGCNT)
 D:$P(PHDAT,U)="YES" SET(DGARY,DGLINE,"Status: "_$P(PHDAT,U,2),32,,,,,,.DGCNT)
 D:$P(PHDAT,U)="NO" SET(DGARY,DGLINE,"Remarks: "_$P(PHDAT,U,3),31,,,,,,.DGCNT)
 ;
 ;Agent orange
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"A/O Exp.: "_$S($G(DGENR("ELIG","AO"))'="":$$EXT^DGENU("AO",DGENR("ELIG","AO")),1:""),14,,,,,,.DGCNT)
 D SET(DGARY,DGLINE,"A/O Exp Loc: "_$S($G(DGENR("ELIG","AOEXPLOC"))'="":$$EXT^DGENU("AOEXPLOC",DGENR("ELIG","AOEXPLOC")),1:""),51,,,,,,.DGCNT)
 ;
 ;Ionizing radiation
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"ION Rad.: "_$S($G(DGENR("ELIG","IR"))'="":$$EXT^DGENU("IR",DGENR("ELIG","IR")),1:""),14,,,,,,.DGCNT)
 ;
 ;Radiation Exposure Method
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"Rad Exp Method: "_$S($G(DGENR("ELIG","RADEXPM"))'="":$$EXT^DGENU("RADEXPM",DGENR("ELIG","RADEXPM")),1:""),8,,,,,,.DGCNT)
 ;
 ;SW Asia Conditions - name change from Env con DG*5.3*688
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"SW Asia Cond."_$S($G(DGENR("ELIG","EC"))'="":$$EXT^DGENU("EC",DGENR("ELIG","EC")),1:""),12,,,,,,.DGCNT)
 ;
 ;Military retirement - new fields added with DG*5.3*672
 S DGLINE=DGLINE+1
 S DGRET=$G(DGENR("ELIG","DISRET"))
 D SET(DGARY,DGLINE,"Mil Disab Retirement: "_$S($G(DGRET)=0:"NO",$G(DGRET)=1:"YES",$G(DGRET)=2:"YES",$G(DGRET)=3:"UNK",1:""),2,,,,,,.DGCNT)
 D SET(DGARY,DGLINE,"Dischrg Due to Disab: "_$S($G(DGENR("ELIG","DISLOD"))'="":$$EXT^DGENU("DISLOD",DGENR("ELIG","DISLOD")),1:""),42,,,,,,.DGCNT)
 ;
 ;Combat Vet End Date (added for DG*5.3*564 - HVE Phase III)
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"Combat Vet End Date: "_$S($G(DGENR("ELIG","CVELEDT"))'="":$$EXT^DGENU("CVELEDT",DGENR("ELIG","CVELEDT")),1:""),3,,,,,,.DGCNT)
 ;
 ;Eligible for medicaid
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"Eligible for MEDICAID: "_$S($G(DGENR("ELIG","MEDICAID"))'="":$$EXT^DGENU("MEDICAID",DGENR("ELIG","MEDICAID")),1:""),1,,,,,,.DGCNT)
 ;
 ;Service connected and percentage
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"",1,,,,,,.DGCNT)
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"Svc Connected: "_$S($G(DGENR("ELIG","SC"))'="":$$EXT^DGENU("SC",DGENR("ELIG","SC")),1:""),9,,,,,,.DGCNT)
 D SET(DGARY,DGLINE,"SC Percent: "_$S($G(DGENR("ELIG","SCPER"))'="":$$EXT^DGENU("SCPER",DGENR("ELIG","SCPER"))_"%",1:""),52,,,,,,.DGCNT)
 ;
 ;Aid & attendance and housebound
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"Aid & Attendance: "_$S($G(DGENR("ELIG","A&A"))'="":$$EXT^DGENU("A&A",DGENR("ELIG","A&A")),1:""),6,,,,,,.DGCNT)
 D SET(DGARY,DGLINE,"Housebound: "_$S($G(DGENR("ELIG","HB"))'="":$$EXT^DGENU("HB",DGENR("ELIG","HB")),1:""),52,,,,,,.DGCNT)
 ;
 ;VA Pension
 ;Unemployable (added for DG*5.3*564 - HVE Phase III)
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"VA Pension: "_$S($G(DGENR("ELIG","VAPEN"))'="":$$EXT^DGENU("VAPEN",DGENR("ELIG","VAPEN")),1:""),12,,,,,,.DGCNT)
 D SET(DGARY,DGLINE,"Unemployable: "_$S($G(DGENR("ELIG","UNEMPLOY"))'="":$$EXT^DGENU("UNEMPLOY",DGENR("ELIG","UNEMPLOY")),1:""),50,,,,,,.DGCNT)
 ;
 ;Total check amount
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"Total Check Amount: "_$S($G(DGENR("ELIG","VACKAMT"))'="":$$EXT^DGENU("VACKAMT",DGENR("ELIG","VACKAMT")),1:""),4,,,,,,.DGCNT)
 ;
 ;PROJ 112/SHAD - DG*5.3*653
 I $G(DGENR("ELIG","SHAD"))=1 D
 .D SET(DGARY,DGLINE,"Proj 112/SHAD: "_$$EXT^DGENU("SHAD",DGENR("ELIG","SHAD")),49,,,,,,.DGCNT)
 ;
 ;Eligibility code
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"Eligibility Code: "_$S($G(DGENR("ELIG","CODE"))'="":$$EXT^DGENU("CODE",DGENR("ELIG","CODE")),1:""),6,,,,,,.DGCNT)
 ;
 ;Means test
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"Means Test Status: "_$S($G(DGENR("ELIG","MTSTA"))'="":$$EXT^DGENU("MTSTA",DGENR("ELIG","MTSTA")),1:""),5,,,,,,.DGCNT)
 ;
 ;Veteran Catastrophically Disabled
 S DGLINE=DGLINE+1
 D SET(DGARY,DGLINE,"Veteran CD Status: "_$S($G(DGENR("ELIG","VCD"))'="":$$EXT^DGENU("VCD",DGENR("ELIG","VCD")),1:""),5,,,,,,.DGCNT)
 ;
 ;Set line to start on next page
 F DGLINE=DGLINE+1:1:DGSTART+VALM("LINES") D SET(DGARY,DGLINE,"",1,,,,,,.DGCNT)
 Q
 ;
SET(DGARY,DGLINE,DGTEXT,DGCOL,DGON,DGOFF,DGSUB,DGNUM,DGDATA,DGCNT) ; moved to
 ;DGENL2 as DGENL1 was getting too big
 I $G(DGCOL)']"" S DGCOL=""
 I $G(DGON)']"" S DGON=""
 I $G(DGOFF)']"" S DGOFF=""
 I $G(DGSUB)']"" S DGSUB=""
 I $G(DGNUM)']"" S DGNUM=""
 I $G(DGDATA)']"" S DGDATA=""
 D SET^DGENL2(DGARY,DGLINE,DGTEXT,DGCOL,DGON,DGOFF,DGSUB,DGNUM,DGDATA,.DGCNT)
 Q
PHEART(DFN,DGENRIEN,PHENRDT) ;move to DGENL2
 N PHI,PHST,PHRR,PHDAT
 S PHDAT=$$PHEART^DGENL2(DFN,$G(DGENRIEN),$G(DGENR("DATETIME")))
 S PHI=$P(PHDAT,U),PHST=$P(PHDAT,U,2),PHRR=$P(PHDAT,U,3)
 I ($G(PHI)]""!($G(PHST)]"")!($G(PHRR)]"")) Q $G(PHI)_"^"_$G(PHST)_"^"_$G(PHRR)
 Q ""
