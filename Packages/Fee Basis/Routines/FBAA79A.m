FBAA79A ;AISC/GRR-PRINT 7079 CONTINUED ;1/12/98
 ;;3.5;FEE BASIS;**12,103**;JAN 30, 1995;Build 19
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 S DIWL=1,DIWF="WC120" K ^UTILITY($J,"W")
 I $D(^FBAAA(DFN,1,FBK,2)) F FBRR=0:0 S FBRR=$O(^FBAAA(DFN,1,FBK,2,FBRR)) Q:FBRR'>0  S FBXX=^(FBRR,0),X=FBXX D ^DIWP
 D ^DIWW:$D(FBXX) K FBXX
 W !,?40,"FOR VA USE ONLY",!,UL
 W !," (5) STATE CODE | (6) COUNTY CODE | (7) TYPE OF | (8) YEAR OF BIRTH | (9) WAR | (10) PURPOSE |",!,?16,"|",?34,"|",?37,"PATIENT",?48,"|",?68,"|",?78,"|",?93,"|"
 W !,?7,FBI(5),?16,"|",?23,CC,?34,"|",?41,FBPATT,?48,"|",?58,YOB,?68,"|",?74,POS,?78,"|",?87,POV,?93,"|",!,UL
 W !,"STATION OF JURISDICTION",?48,"|",?78,"|",?80," (11) CODE",?100,"| (12) SEX",!,?48,"|",?78,"|",?100,"|","  ",$S(SEX="F":"FEMALE",1:"MALE")
 W !,"Veterans Administration",?48,"|",?78,"|",?100,"|",$E(UL,101,120)
 W !,FBS(2),?48,"|",?78,"|",?80,$S(CODE=1:"SHORT TERM - 1",CODE=2:"HOME NURSING - 2",CODE=3:"ID CARD STATUS - 3",1:""),?100,"| (13) POW"
 W:FBS(3)]"" !,FBS(3),?48,"|",?78,"|",?100,"|","  ",$S(POW="Y":"YES",1:"NO")
 W !,FBS(4)," ",SSTCD," ",FBS(6),?48,"|",?78,"|",?100,"|" W:FBS(3)']"" "  ",$S(POW="Y":"YES",1:"NO") W !,?48,$E(UL,49,120)
 W !,?48,"| APPROVED BY (Name and Title)",?110,"(",$S($D(^VA(200,DUZ,0)):$P(^(0),"^",2),1:""),")",!,?48,"|"
 W !,"TELEPHONE: ",FBS(7),?48,"|",?50,FBS(8),!,?48,"|",?50,FBS(9),!,UL
 W !,?32,"Information On Veterans Administration Program",!
 W !,"Acceptance of this request to render the prescribed services will constitute an agreement which is subject",!,"to the following: ",!
 W !,?3,"I. SERVICES. If services are not initiated, please return this document to the Station of Jurisdiction with a brief"
 W !,?5,"explanation. Unless approved by the VA, services are limited in type and extent to those shown.",!
 W !,?3,"II. PERIOD OF VALIDITY. Service must be performed within the period of validity indicated.",!,?5,"If a longer time is needed, please request an extension.",!
 W !,?3,"III. REPORTS. Clinical reports are required when an examination only has been requested. Please ",!,?5,"submit reports promptly to the Station Of Jurisdiction.",!
 W !,?3,"IV. STATEMENT OF ACCOUNTS. Submit a Statement of Account in your usual manner. Your statement must",!,?5,"include: (1) Patient's Name; (2) Identification NO.; (3) Treatment (CPT) and Dates Rendered; and (4) Fees.",!
 W !,?3,"V. FEES. Fees claimed may not exceed those made to the general public for like services.",!
 W !,?3,"VI. PAYMENT. Payment by the VA for services rendered and approved is payment in full.",!
 W !,?3,"VII. HOSPITALIZATION. When a need for hospital care is indicated, please call the Station of Jurisdiction",!,?5,"for assistance in admitting the veteran to a VA hospital.",!
 W !,?3,"VIII. INQUIRIES. Additional information when required may be obtained by contacting the Station Of Jurisdiction.",!
 W !,?3,"IX. When submitting claims for payment you must include the NPI and Taxonomy Code of the rendering practitioner, and"
 W !,?5,"the NPI and Taxonomy Code of your organization.  If, under the HIPAA NPI Final Rule"
 W !,?5,"[http://www.cms.hhs.gov/NationalProvIdentStand], your organization is an ""atypical"" provider furnishing services such as"
 W !,?5,"taxi, home and vehicle modifications, insect control, habilitation, and respite services and is therefore ineligible"
 W !,?5,"for an NPI, it is important that you indicate ""Ineligible for NPI"" on your claim form ."
 W !,UL
 W !?3,"VA Form 10-7079"
 W ?85,"Date Printed: ",$$FMTE^XLFDT(DT),!
 Q
