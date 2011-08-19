FBCH78A ;AISC/DMK-PRINT 7078 CONTINUED FROM FBCHP78 ;06FEB89
 ;;3.5;FEE BASIS;**103**;JAN 30, 1995;Build 19
 ;;Per VHA Directive 2004-038, this routine should not be modified.
HED W:'$G(FBPG) @IOF K:$G(FBPG) FBPG W UL,!,?5,"Department of Veterans Affairs",?58,"AUTHORIZATION AND INVOICE FOR MEDICAL AND HOSPITAL SERVICES",!,UL,!
 Q
BOT W !,"SPECIAL PROVISIONS: Acceptance of this authorization to render service is governed by the following:",!!
 W "1. ACCEPTANCE OF THIS AUTHORIZATION AND PROVIDING OF SUCH TREATMENT OR SERVICES SUBJECTS YOU, THE PROVIDER OF CARE, TO",!,?3,"THE PROVISIONS OF PUBLIC LAW 93-579, THE PRIVACY ACT OF 1974, TO THE EXTENT OF THE RECORDS "
 W "PERTAINING TO THE VA",!,?3,"AUTHORIZED TREATMENT OR SERVICES OF THIS VETERAN.",!
 W !,"2. Fees or rates listed represent maximum allowance for services specified. In no event should charges be made to the",!,?3,"VA in excess of usual and customary charges to the general public for similar services.",!
 W !,"3. Payment by the VA is payment in full for authorized services rendered.",!
 W !,"4. Unless otherwise approved by the VA, services are limited in type and extent to those shown on this authorization.",!,?3,"If services are not initiated for any reason, return a copy of the authorization to the issuing ",!
 W ?3,"office with a brief explanation.",!
 W !,"5. A copy of the Operative Report will be forwarded to the Authorizing station within one week following any major",!,?3,"surgery.",!
 W !,"6. A copy of the hospital summary will be forwarded to the authorizing station within ten work days following the ",!,?3,"release of the patient from the hospital.",!
 W !,"7. When submitting claims for payment you must include the NPI and Taxonomy Code of the rendering practitioner,"
 W !,?3,"and the NPI and Taxonomy Code of your organization.  If, under the HIPAA NPI Final Rule"
 W !,?3,"[http://www.cms.hhs.gov/NationalProvIdentStand], your organization is an ""atypical"" provider furnishing services such"
 W !,?3,"as taxi, home and vehicle modifications, insect control, habilitation, and respite services and is therefore"
 W !,?3,"ineligible for an NPI, it is important that you indicate ""Ineligible for NPI"" on your claim form.",!
 W UL,!,?16,"All questions relating to this authorization should be referred to the issuing VA Office",!,UL,!,"VA Form 10-7078" Q
 ;
FISCAL ;SETS THE FISCAL SYMBOL BLOCK FOR 7078
 S PRC("SITE")=FB("SITE"),PRCS("X")=PRC("SITE")_"-"_$P($P(FB(0),"^"),"."),PRCS("TYPE")="FB" D EN1^PRCS58
 S FB("SYM")=$P(Y,"^",4)_" "_$P(FB(0),"^")_"  FCP "_$P(Y,U,3) K PRC("SITE"),PRCSI,Y Q
 ;
CONT(X,Y) ;get contract for CNH authorization
 ;X=IEN of vendor
 ;Y=from date of authorization
 I $S('$G(X):1,'$G(Y):1,1:0) Q ""
 I '$O(^FBAA(161.21,"ACR",X,-Y+.9)) Q ""
 N Z
 S Z=$P(^FBAA(161.21,+$O(^(+$O(^FBAA(161.21,"ACR",X,-Y+.9)),0)),0),U,1,3)
 Q $S($P(Z,U,3)>Y:$P(Z,U),1:"")
