RMPR9P23 ;PHX/HNB -PRINT PURCHASE CARD FORM ;3/1/1996
 ;;3.0;PROSTHETICS;**153**;Feb 09, 1996;Build 10
PRI ;ENTRY POINT FOR PRINTING PRIVACY ACT (GUI WINDOWS) FOR 10-2421 AND 10-55 AND 2419
 N CT,PRTW
 F CT=1:1 S PRTW=$T(TEXT+CT) Q:PRTW=""  S CNT=CNT+1,^TMP($J,"RMPRPRT",CNT)=$P(PRTW,";",2)
 Q
TEXT ;Privacy Act text
 ;
 ;
 ;VAAR- 852.273-75 SECURITY REQUIREMENTS FOR UNCLASSIFIED INFORMATION
 ;                 TECHNOLOGY RESOURCES (Interim - October 2008)
 ;
 ;(a) The contractor and their personnel shall be subject to the same Federal laws
 ;,regulations, standards and VA policies as VA personnel, regarding information
 ;and information system security. These include, but are not limited to Federal
 ;Information Security Management Act (FISMA), Appendix III of 0MB Circular A-130,
 ;and guidance and standards, available from the Department of Commerce's National
 ;Institute of Standards and Technology (NIST). This also includes the use of
 ;common security configurations available from NIST's Web site at:
 ;http://checklists.nist.gov.
 ;
PRI1 ;(b) To ensure that appropriate security controls are in place, contractors must
 ;follow the procedures set forth in 'VA Information and Information System
 ;Security/Privacy Requirements for IT Contracts' located at the following Web
 ;site: http://www.iprm.oit.va.gov.
 ;
PRI2 ;(c) These provisions shall apply to all contracts in which VA sensitive
 ;information is stored, generated, transmitted, or exchanged by VA, a contractor,
 ;subcontractor or a third-party, or on behalf of any of these entities regardless
 ;of format or whether it resides on a VA system or contractor/subcontractor's
 ;electronic information system(s) operating for or on the VA's behalf.
 ;
PRI3 ;(d) Clauses (a) and (b) shall apply to current and future contracts and
 ;acquisition vehicles including, but not limited to, job orders, task orders
 ;letter contracts, purchase orders, and modifications. Contracts do not include
 ;grants and cooperative agreements covered by 31 U.S.C. §6301 et seq.
 Q
