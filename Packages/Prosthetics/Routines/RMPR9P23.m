RMPR9P23 ;PHX/HNB -PRINT PURCHASE CARD FORM ;3/1/1996
 ;;3.0;PROSTHETICS;**153,166**;Feb 09, 1996;Build 2
PRI ;ENTRY POINT FOR PRINTING PRIVACY ACT (GUI WINDOWS) FOR 10-2421 AND 10-55 AND 2419
 N CT,PRTW
 F CT=1:1 S PRTW=$T(TEXT+CT) Q:PRTW=""  S CNT=CNT+1,^TMP($J,"RMPRPRT",CNT)=$P(PRTW,";",2)
 Q
TEXT ;Privacy Act text
 ;
 ;
 ;Security Requirements Interim Guidance - January 2013 (Per Acquisition Policy
 ;               Flash 12-04, dated 2/2/12, suspending VAAR clause 852.273-75)
 ;
 ;A.    Any contractor and/or subcontractor retained to do work for VA under
 ;this Contract that requires the access, use, storage, modification, or 
 ;transmission of VA Sensitive Personal Information (SPI) must follow and 
 ;adhere to the security controls, enhancements, compensating controls,
 ;protocols, regulations, and VA directions as the Contracting Officer 
 ;(CO) shall direct, including, but not limited to those derived from the
 ;Federal Information Security Management Act (FISMA), OMB Circular No. 
 ;A-130, and VA Handbook 6500/6500.6.  The contractor must report any data
 ;breach according to the protocols and timeframes in HB 6500. 
 ;
PRI1 ;B.      If any contractor/sub-contractor retained to do work for VA under
 ;this Contract requires access, use, etc., of VA SPI as aforesaid, and if an
 ;actionable data breach occurs because of the contractor/subcontractor's acts, 
 ;omissions, or negligence in following the VA-directed security controls, 
 ;enhancements, compensating controls, protocols, and/or measures, including,
 ;but not limited to the sources above, the contractor/subcontractor is 
 ;further subject to the statutory requirement to assess liquidated damages 
 ;against contractors and/or subcontractors under 38 U.S.C. §5725 in the event
 ;of a breach of Sensitive Personal Information (SPI)/Personally Identifiable 
 ;Information (PII).  Said liquidated damages shall be assessed at $37.50 
 ;per affected Veteran or beneficiary.  A breach in this context includes 
 ;the unauthorized acquisition, access, use, or disclosure of VA SPI which
 ;compromises not only the information's security or privacy but that of the
 ;Veteran or beneficiary as well as the potential exposure or wrongful 
 ;disclosure of such information as a result of a failure to follow proper 
 ;data security controls and protocols.
 Q
