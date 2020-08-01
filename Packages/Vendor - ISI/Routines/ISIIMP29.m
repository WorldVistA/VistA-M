ISIIMP29 ;ISI GROUP/MLS -- Non-VA MEDS IMPORT CONT.
 ;;3.0;ISI_DATA_LOADER;;Jun 26, 2019;Build 80
 ;
 ; VistA Data Loader 2.0
 ;
 ; Copyright (C) 2012 Johns Hopkins University
 ;
 ; VistA Data Loader is provided by the Johns Hopkins University School of
 ; Nursing, and funded by the Department of Health and Human Services, Office
 ; of the National Coordinator for Health Information Technology under Award
 ; Number #1U24OC000013-01.
 ;
 ;Licensed under the Apache License, Version 2.0 (the "License");
 ;you may not use this file except in compliance with the License.
 ;You may obtain a copy of the License at
 ;
 ;    http://www.apache.org/licenses/LICENSE-2.0
 ;
 ;Unless required by applicable law or agreed to in writing, software
 ;distributed under the License is distributed on an "AS IS" BASIS,
 ;WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 ;See the License for the specific language governing permissions and
 ;limitations under the License.
 ;
 Q
 ;
VALIDATE() ;
 ; Validate import array contents
 S ISIRC=$$VALMEDS^ISIIMPUI(.ISIMISC)
 Q ISIRC
 ;
MAKENVA() ;
 ; Create patient(s)
 S ISIRC=$$MEDS(.ISIMISC)
 Q ISIRC
 ;
MEDS(ISIMISC) ;Create med order entry
 ; Input - ISIMISC(ARRAY)
 ; Format:  ISIMISC(PARAM)=VALUE
 ;     eg:  ISIMISC("DFN")=123455
 ;
 ; Output - ISIRC [return code]
 ;          ISIRESUL(0)=1 [if successful]
 ;          ISIRESUL(1)=PSOIEN [if successful]
 ;
 N ORVP,ORNP,ORL,DLG,ORDG,ORIT,ORIFN,ORDIALOG,ORDEA,ORAPPT,ORSRC,OREVTDF,DISPDRUG
 N DOSAGE,ROUTE,SCHED,RES,RTIEN
 ;
 S ISIRC=1
 D CREATE
 I +ISIRC<0 Q ISIRC
 S ISIRESUL(0)=1
 S ISIRESUL(1)=ORIFN
 Q ISIRC
 ;
CREATE ;
 ;
 N EXIT
 S ISIRC=0,ORIFN=""
 S ORVP=ISIMISC("DFN") ;"" ;POINTER TO PATIENT FILE (#2)
 S ORNP=DUZ
 S ORL=$O(^SC("B","EMERGENCY DEPARTMENT",0))
 S DLG="PSH OERR" ; Order Dialog for NVA Meds
 S ORDG=$O(^ORD(100.98,"B","NON-VA MEDICATIONS",0))
 S ORIT=$O(^ORD(101.41,"B",DLG,0)) ; Quick Order Dialog for NVA Meds
 ; Build the Order Dialog array
 S ORDIALOG($$ITEM("OR GTX ORDERABLE ITEM"),1)=ISIMISC("DRUG")
 S ORDIALOG($$ITEM("OR GTX INSTRUCTIONS"),1)=ISIMISC("DOSAGE")
 N RTIEN S RTIEN=$O(^PS(51.2,"B",ISIMISC("ROUTE"),0))
 S ORDIALOG($$ITEM("OR GTX ROUTE"),1)=RTIEN
 S ORDIALOG($$ITEM("OR GTX SCHEDULE"),1)=ISIMISC("SIG")
 S ORDIALOG(0,1)=""
 S ORDIALOG($$ITEM("OR GTX WORD PROCESSING 1"),1)="ORDIALOG(""WP"","_$$ITEM("OR GTX WORD PROCESSING 1")_",1)"
 S ORDIALOG($$ITEM("OR GTX STRENGTH"),1)=""
 S ORDIALOG($$ITEM("OR GTX START DATE/TIME"),1)=$$FMTE^XLFDT(ISIMISC("DATE"))
 S ORDIALOG($$ITEM("OR GTX SIG"),1)="ORDIALOG(""WP"","_$$ITEM("OR GTX SIG")_",1)"
 S ORDIALOG("WP",$$ITEM("OR GTX SIG"),1,1,0)=ISIMISC("DOSAGE")_" "_$P(^PS(51.2,RTIEN,0),U,2)_" "_ISIMISC("SIG")
 S ORDIALOG($$ITEM("OR GTX DOSE"),1)=""
 S ORDIALOG($$ITEM("OR GTX DISPENSE DRUG"),1)=""
 S ORDIALOG($$ITEM("OR GTX DRUG NAME"),1)=""
 S ORDIALOG($$ITEM("OR GTX PATIENT INSTRUCTIONS"),1)="ORDIALOG(""WP"","_$$ITEM("OR GTX PATIENT INSTRUCTIONS")_",1)"
 S ORDIALOG("WP",$$ITEM("OR GTX PATIENT INSTRUCTIONS"),1,1,0)="Patient Instructions via Auto feed from ISI Data Loader."
 S ORDIALOG($$ITEM("OR GTX STATEMENTS"),1)="ORDIALOG(""WP"","_$$ITEM("OR GTX STATEMENTS")_",1)"
 S ORDIALOG("WP",$$ITEM("OR GTX STATEMENTS"),1,1,0)=""
 S ORDIALOG("WP",$$ITEM("OR GTX STATEMENTS"),1,2,0)=ISIMISC("DISC")
 S ORDIALOG("ORCHECK")=2
 S ORDIALOG("ORCHECK","NEW","2","1")="99^2^Remote Order Checking not available - checks done on local data only"
 S ORDIALOG("ORCHECK","NEW","2","2")="25^2^||"_$H_",NEW&These checks could not be completed for this patient:"
 S ORDIALOG("ORTS")=0
 S ORDEA=""
 S ORAPPT=""
 S ORSRC=""
 S OREVTDF=0
 ; Call the Non-VA Meds Save Dialog
 D SAVE^ORWDX(.RES,ORVP,ORNP,ORL,DLG,ORDG,ORIT,.ORIFN,.ORDIALOG,ORDEA,ORAPPT,ORSRC,OREVTDF)
 S X="^ZBNT($J,""NVAMEDS""," D DOLRO^%ZOSV
 I +ORIFN D
 . N ORWREC,ORWLST
 . S ORWREC(1)=ORIFN_";1^1^1^E"
 . D SEND^ORWDX(.ORWLST,ISIMISC("DFN"),DUZ,ORL,"",.ORWREC)
 Q
 ;
ITEM(NAME) ; Get the ORDERABLE ITEMS IEN
 Q $O(^ORD(101.41,"B",NAME,0))
