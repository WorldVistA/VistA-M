PRCHP184 ;WISC/RR-PRINT ROUTINES FOR FORM 18 REQUEST FOR QUOTATIONS ; 2/22/01 4:54pm
V ;;5.1;IFCAP;**9**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;New clause, #52.219-1 as of 10/25/2000.
EN01 ;Routines PRCHP182 & PRCHQM4 use this clause,
 ;
 ;Setup few column variables, CA-CE.
 N CA,CB,CC,CD,CE
 S CA=5,CB=9,CC=12,CD=13,CE=35
 ;
 W ?CA,"52.219-1 SMALL BUSINESS PROGRAM REPRESENTATIONS (OCT 2000)",!!
 W ?CA,"(a) (1) The North American Industry Classification System (NAICS) code",!
 W ?CA,"for this acquisition is ____________.",!!
 W ?CB,"(2) The small business size standard is $__________.",!!
 W ?CB,"(3) The small business size standard for a concern which submits an",!
 W ?CA,"offer in its own name, other than on a construction or service contract,",!
 W ?CA,"but which proposes to furnish a product which it did not itself",!
 W ?CA,"manufacture, is 500 employees.",!!
 W ?CA,"(b) Representations.",!
 W ?CC,"(1)The offeror represents as part of its offer that it __ is, __ is",!
 W ?CA,"not a small business concern.",!!
 W ?CC,"(2)[Complete only if the offeror represented itself as a small",!
 W ?CA,"business concern in paragraph (b)(1) of this provision.] The offeror",!
 W ?CA,"represents, for general statistical purposes, that it ___ is, ___ is",!
 W ?CA,"not a small disadvantaged business concern as defined in 13 CFR 124.1002.",!!
 W ?CC,"(3)[Complete only if the offeror represented itself as a small",!
 W ?CA,"business concern in paragraph (b)(1) of this provision.] The offeror",!
 W ?CA,"represents as part of its offer that it ___ is, ___ is not a women-owned",!
 W ?CA,"small business concern.",!!
 W ?CC,"(4)[Complete only if the offeror represented itself as a small",!
 W ?CA,"business concern in paragraph (b)(1) of this provision.]  The offeror",!
 W ?CA,"represents as part of its offer that it ___ is, ___ is not a veteran-owned",!
 W ?CA,"small business concern.",!!
 W ?CC,"(5)[Complete only if the offeror represented itself as a veteran-",!
 W ?CA,"owned small business concern in paragraph (b)(4) of this provision.] The",!
 W ?CA,"offeror represents as part of its offer that it ___ is, ___ is not a",!
 W ?CA,"service-disabled veteran-owned small business concern.",!!
 W ?CC,"(6)[Complete only if offeror represented itself as a small business",!
 W ?CA,"concern in paragraph (b)(1) of this provision.] The offeror represents, as",!
 W ?CA,"part of its offer, that--",!!
 W ?CA,"(i)It ___ is, ___ is not a HUBZone small business concern listed, on",!
 W ?CA,"the date of this representation, on the List of Qualified HUBZone Small",!
 W ?CA,"Business Concerns maintained by the Small Business Administration, and",!
 W ?CA,"no material change in ownership and control, principal office of",!
 W ?CA,"ownership, or HUBZone employee percentage has occurred since it was",!
 W ?CA,"certified by the Small Business Administration in accordance with 13",!
 W ?CA,"CFR Part 126; and",!!
 W ?CA,"(ii) It ___ is, ___ is not a joint venture that complies with the",!
 W ?CA,"requirements of 13 CFR Part 126, and the representation in paragraph",!
 W ?CA,"(b)(6)(i) of this provision is accurate for the HUBZone small business",!
 W ?CA,"concern or concerns that are participating in the joint venture.[The",!
 W ?CA,"offeror shall enter the name or names of the HUBZone small business",!
 W ?CA,"concern or concerns that are participating in the joint venture:",!
 W ?CA,"__________________________.] Each HUBZone small business concern",!
 W ?CA,"participating in the joint venture shall submit a separate signed",!
 W ?CA,"copy of the HUBZone representation.",!!
 W ?CA,"(c) Definitions. As used in this provision -",!!
 W ?CB,"Service disabled veteran-owned small business concern (1) means a",!
 W ?CB,"small business concern- (i)Not less than 51 percent of which is owned",!
 W ?CB,"by one or more service-disabled veterans or, in the case of any",!
 W ?CB,"publicly owned business, not less than 1 percent of the stock of which",!
 W ?CB,"is owned by one or more service-disabled veterans; and",!!
 W ?CB,"(ii)The management and daily business operations of which are",!
 W ?CB,"controlled by one or more service-disabled veterans or, in the case",!
 W ?CB,"of a veteran with permanent and severe disability, the spouse or",!
 W ?CB,"permanent caregiver of such veteran.",!!
 W ?CB,"(2)Service disabled veterans means a veteran, as defined in 38 U.S.C.",!
 W ?CB,"101(2), with a disability that is service-connected, as defined in",!
 W ?CB,"38 U.S.C. 101(16).",!!
 W ?CB,"Small business concern means a concern, including its affiliates,",!
 W ?CB,"that is independently owned  and operated, not dominant in the field",!
 W ?CB,"of operation in which it is bidding on Government contracts, and",!
 W ?CB,"qualified as a small business under the criteria in 13 CFR Part 121",!
 W ?CB,"and the size standard in paragraph (a) of this provision.",!!
 W ?CB,"Women-owned small business concern means a small business concern ",!!
 W ?CB,"(1)Which is at least 51 percent owned by one or more women or, in the",!
 W ?CB,"case of any publicly owned business, at least 51 percent of the stock",!
 W ?CB,"of which is owned by one or more women; and",!!
 W ?CB,"(2)Whose management and daily business operations are controlled by",!
 W ?CB,"one or more women.",!!
 W ?CB,"Veteran-owned small business concern means a small business concern -",!
 W ?CB,"(1)Not less than 51 percent of which is owned by one or more veterans",!
 W ?CB,"(as defined at 38 U.S.C. 101(2) or, in the case of any publicly owned",!
 W ?CB,"business, not less than 51 percent of the stock of which is owned by",!
 W ?CB,"one or more veterans; and",!!
 W ?CB,"(2)The management and daily business operations of which are controlled",!
 W ?CB,"by one or more veterans.",!!
 W ?CA,"(d)Notice.(1)If this solicitation is for supplies and has been set aside,",!
 W ?CA,"in whole or in part, for small business concerns, then the clause in this",!
 W ?CA,"solicitation providing notice of the set-aside contains restrictions on the",!
 W ?CA,"source of the end items to be furnished.",!!
 W ?CB,"(2)Under 15 U.S.C. 645(d), any person who misrepresents a firm's",!
 W ?CB,"status as a small, HubZone small, small disadvantaged, or women-owned",!
 W ?CB,"small business concern in order to obtain a contract to be awarded",!
 W ?CB,"under the preference programs established pursuant to section 8(a),",!
 W ?CB,"8(d), 9, or 15 of the Small Business Act or any other provision of",!
 W ?CB,"Federal law that specifically references section 8(d) for a definition",!
 W ?CB,"of program eligibility, shall--  ",!!
 W ?CD,"(i)Be punished by imposition of fine, imprisonment, or both;",!!
 W ?CD,"(ii)Be subject to administrative remedies, including suspension",!
 W ?CD,"and debarment; and",!!
 W ?CD,"(iii)Be ineligible for participation in programs conducted under",!
 W ?CD,"the authority of the Act.",!
 W ?CE,"(End of provision)",!!
 Q
