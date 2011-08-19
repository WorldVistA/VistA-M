PRCHP182 ;SF/FKV-PRINT ROUTINES FOR FORM 18 REQUEST FOR QUOTATIONS ; 2/27/01 2:47pm
V ;;5.1;IFCAP;**9**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
EN D ENDPG^PRCHP181 W !!,?20,"REPRESENTATIONS, CERTIFICATIONS, AND PROVISIONS",!!!
 W ?5,"The following representation applies when the contract is to be performed inside the",!
 W ?5,"United States, its territories or possessions, Puerto Rico, the Trust Territory of",!
 W ?5,"the Pacific Islands, or the District of Columbia.",!!!
 ;
 ;Clause 52.219-1 has been updated. Call routine PRCHP184.
 ;As of 10/25/2000
 ;
 D EN01^PRCHP184
 ;
 ;Replacing provision 52.219-4 with 52.219-6.
 W ?5,"52.219-6 Notice of Total Small Business Set-Aside. (JUL 1996)",!!
 W ?9,"As prescribed in 19.508(c), insert the following clause:",!!
 W ?5,"NOTICE OF TOTAL SMALL BUSINESS SET-ASIDE  (JUL 1996)",!
 W ?5,"(a)  Definition.",!
 W ?10,"Small business concern, as used in this clause, means a concern,",!
 W ?10,"including its affiliates, that is independently owned and operated,",!
 W ?10,"not dominant in the field of operation in which it is bidding on",!
 W ?10,"Government contracts, and qualified as a small business under the",!
 W ?10,"size standards in this solicitation.",!
 W ?5,"(b)  General.",!
 W ?10,"(1) Offers are solicited only from small business concerns.",!
 W ?14,"Offers received from concerns that are not small business",!
 W ?14,"concerns shall be considered non-responsive and will be rejected.",!
 W ?10,"(2) Any award resulting from this solicitation will be made",!
 W ?14,"to a small business concern.",!
 W ?5,"(c)  Agreement.",!
 W ?10,"A small business concern submitting an offer in its own name agrees to",!
 W ?10,"furnish, in performing the contract, only end items manufactured or",!
 W ?10,"produced by small business concerns in the United States.  The term",!
 W ?10,"United States includes its territories and possessions, the Commonwealth",!
 W ?10,"of Puerto Rico, the trust territory of the Pacific Islands, and the",!
 W ?10,"District of Columbia.  If this procurement is processed under simplified",!
 W ?10,"acquisition procedures and the total amount of this contract does not",!
 W ?10,"exceed $25,000 a small business concern may furnish the product of",!
 W ?10,"any domestic firm.  This paragraph does not apply in connection with",!
 W ?10,"construction or service contracts.",!
 W ?33,"(End of clause)",!
 ;
 S PRCHDY=60 D ENDPG^PRCHP181
 W !!!,?5,"852.219-70 VETERAN-OWNED SMALL BUSINESS  (DEC 90)",!!
 W ?10,"The offeror represents that the firm submitting this offer _____ is _____ is",!,?5,"not, a veteran-owned small business, _____ is _____ is not, a Vietnam era",!
 W ?5,"veteran-owned small business, and _____ is _____is not, a disabled veteran-owned",!,?5,"small business.  A veteran-owned small business is defined as a small business, at",!
 W ?5,"least 51 percent of which is owned by a veteran, who also controls and operates",!,?5,"the business.  Control in this context means exercising the power to make",!
 W ?5,"policy decisions.  Operate in this context means actively involved in",!,?5,"day-to-day management.  For the purpose of this definition, eligible veterans",!
 W ?5,"include:",!,?6,"(a) A person who served in the U.S. Armed Forces and who was discharged",!,?5,"or released under conditions other than dishonorable.",!
 W ?6,"(b) Vietnam era veterans who served for a period of more than 180 days, any",!,?5,"part of which was between August 5, 1964 and May 7, 1975, and were discharged",!
 W ?5,"under conditions other than dishonorable.",!,?6,"(c) Disabled veterans with a minimum compensable disability of 30 percent,",!,?5,"or a veteran who was discharged for disability.",!!
 W ?5,"Failure to execute this representation will be deemed a minor informality and the",!,?5,"bidder or offeror shall be permitted to satisfy the requirement prior to award",!
 W ?5,"(see FAR 14.405).",!!!
 W !!,"Exception to SF-18",?60,"SF-18 ADP (Rev 10-83)",!,"Approved by OIRM ____",?35,"PAGE "_PRCHPAGE_"--LAST PAGE"
 D PRTD^PRCHP183 W !
 ; *** RETURN TO READ THE NEXT VENDOR IN ^TMP
 G ENDRPT^PRCHP18
