VAFCEHU4 ;BIR/LTL,PTD-File utilities for 391.98 ;08/26/97
 ;;5.3;Registration;**149,307,479**;Aug 13, 1993
 ;
 ;Check for null incoming data elements to fire outgoing update
EN ;SEX - .02 - VADM(5)
 I (@VAFCB@(2,.02)[U),($P(VADM(5),U,2)]"") S VAFCQ(1)=1 G CHQ
 ;MARITAL STATUS - .05 - VADM(10)
 I (@VAFCB@(2,.05)="""@"""),($P(VADM(10),U,2)]"") S VAFCQ(1)=1 G CHQ
 ;STREET ADDRESS [1] - .111 - VAPA(1)
 ;I (@VAFCB@(2,.111)="""@"""),(VAPA(1)]""),(VAFCF'[".111;") S VAFCQ(1)=1 G CHQ ;**479
 ;STREET ADDRESS [2] - .112 - VAPA(2)
 ;I (@VAFCB@(2,.112)="""@"""),(VAFCF'[".112;"),(VAPA(2)]"") S VAFCQ(1)=1 G CHQ ;**479
 ;STREET ADDRESS [3] - .113 - VAPA(3)
 ;I (@VAFCB@(2,.113)="""@"""),(VAFCF'[".113;"),(VAPA(3)]"") S VAFCQ(1)=1 G CHQ ;**479
 ;CITY - .114 - VAPA(4)
 ;I (@VAFCB@(2,.114)="""@"""),(VAFCF'[".114;"),(VAPA(4)]"") S VAFCQ(1)=1 G CHQ ;**479
 ;STATE - .115 - VAPA(5)
 ;I (@VAFCB@(2,.115)="""@"""),(VAFCF'[".115;"),($P(VAPA(5),U,2)]"") S VAFCQ(1)=1 G CHQ ;**479
 ;ZIP+4 - .1112 - VAPA(11)
 ;I (@VAFCB@(2,.1112)="""@"""),(VAFCF'[".1112;"),($P(VAPA(11),U)]"") S VAFCQ(1)=1 G CHQ ;**479
 ;COUNTY CODE - .117 - VAPA(7)
 ;I '@VAFCB@(2,.117)!(@VAFCB@(2,.117)="""@"""),(VAFCF'[".117;"),$P(VAPA(7),U) S VAFCQ(1)=1 G CHQ ;**479
 ;PHONE HOME - .131 - VAPA(8)
 I (@VAFCB@(2,.131)="""@"""),(VAFCF'[".131;"),(VAPA(8)]"") S VAFCQ(1)=1 G CHQ
 ;PHONE WORK - .132 - VAPA(2,DFN,.132)
 I (@VAFCB@(2,.132)="""@"""),(VAFCF'[".132;"),(VAPA(2,DFN_",",.132)]"") S VAFCQ(1)=1 G CHQ
 ;K-NAME - .211 - VAPA(2,DFN,.211)
 I (@VAFCB@(2,.211)="""@"""),(VAFCF'[".211;"),(VAPA(2,DFN_",",.211)]"") S VAFCQ(1)=1 G CHQ
 ;K-PHONE - .219 - VAPA(2,DFN,.219)
 I (@VAFCB@(2,.219)="""@"""),(VAFCF'[".219;"),(VAPA(2,DFN_",",.219)]"") S VAFCQ(1)=1 G CHQ
 ;MOTHER'S MAIDEN NAME - .2403 - VAPA(2,DFN,.2403)
 I (@VAFCB@(2,.2403)="""@"""),(VAPA(2,DFN_",",.2403)]"") S VAFCQ(1)=1 G CHQ
 ;SERVICE CONNECTED - .301 - VAPA(2,DFN,.301)
 ;I (@VAFCB@(2,.301)="""@"""),(VAPA(2,DFN_",",.301)]"") S VAFCQ(1)=1 G CHQ
 ;SC% - .302 - VAPA(2,DFN,.302)
 ;I '@VAFCB@(2,.302),VAPA(2,DFN_",",.302) S VAFCQ=1 G CHQ
 ;EMPLOYMENT STATUS - .31115 - VAPA(2,DFN,.31115)
 I (@VAFCB@(2,.31115)="""@"""),(VAPA(2,DFN_",",.31115)]"") S VAFCQ(1)=1 G CHQ
 ;PERIOD OF SERVICE - .323 - VAPA(2,DFN,.323)
 ;I (@VAFCB@(2,.323)="""@"""),(VAPA(2,DFN_",",.323)]"") S VAFCQ(1)=1 G CHQ
 ;DATE OF DEATH - .351 - VAPA(2,DFN,.351)
 I (@VAFCB@(2,.351)="""@"""),VAPA(2,DFN_",",.351) S VAFCQ(1)=1 G CHQ
 ;PRIMARY ELIG CODE - .361 - VAPA(2,DFN,.361)
 ;I (@VAFCB@(2,.361)]"")&(@VAFCB@(2,.361)'=VAPA(2,DFN_",",.361))!((@VAFCB@(2,.361)="")&((VAFCF[".361;"))&((@VAFCB@(2,.361)'=VAPA(2,DFN_",",.361)))) S VAFCQ=1 G CHQ
 ;PATIENT TYPE - 391 - VAPA(2,DFN,391)
 ;I (@VAFCB@(2,391)="""@"""),(VAPA(2,DFN_",",391)]"") S VAFCQ(1)=1 G CHQ
 ;VETERAN (Y/N) - 1901 - VAPA(2,DFN,1901)
 ;I (@VAFCB@(2,1901)="""@"""),VAPA(2,DFN_",",1901) S VAFCQ(1)=1
CHQ I $G(VAFCQ(1)) D AVAFC^VAFCDD01(DFN)
 Q
 ;
WHO(X) ; determine the identity of the sending facility, resolve it into
 ; the institution name.  Prior to the release of RG*1*8, the sending
 ; facility was passed as the name of the institution.  After the
 ; release of RG*1*8, the sending facility is passed in either
 ; format: station # -or- station #~domain.  The station # needs
 ; to be resolved into the name of the institution.
 ; called from: ADD^VAFCEHU1 & CHK^VAFCEHU1
 ; INPUT X-string: sending facility (see desc for possible formats) 
 Q:X="" "" N WHO
 I $$PATCH^XPDUTL("RG*1.0*8") D  ; passed as station# or station#~domain
 .S WHO=+X ; obtain station #
 .S WHO=$$LKUP^XUAF4(WHO) ; from station # to ien
 .S WHO=$$GET1^DIQ(4,+WHO_",",.01) ; from ien to name
 .Q
 E  S WHO=X ; before RG*1.0*8, passed as institution name
 Q $G(WHO)
