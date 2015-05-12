IBDEI03R ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4570,1,4,0)
 ;;=4^C49.0
 ;;^UTILITY(U,$J,358.3,4570,2)
 ;;=^5001124
 ;;^UTILITY(U,$J,358.3,4571,0)
 ;;=C49.11^^22^211^9
 ;;^UTILITY(U,$J,358.3,4571,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4571,1,3,0)
 ;;=3^Malig Neop of Right Upper Limb Connective/Soft Tissue
 ;;^UTILITY(U,$J,358.3,4571,1,4,0)
 ;;=4^C49.11
 ;;^UTILITY(U,$J,358.3,4571,2)
 ;;=^5001126
 ;;^UTILITY(U,$J,358.3,4572,0)
 ;;=C49.12^^22^211^5
 ;;^UTILITY(U,$J,358.3,4572,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4572,1,3,0)
 ;;=3^Malig Neop of Left Upper Limb Connective/Soft Tissue
 ;;^UTILITY(U,$J,358.3,4572,1,4,0)
 ;;=4^C49.12
 ;;^UTILITY(U,$J,358.3,4572,2)
 ;;=^5001127
 ;;^UTILITY(U,$J,358.3,4573,0)
 ;;=C49.21^^22^211^8
 ;;^UTILITY(U,$J,358.3,4573,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4573,1,3,0)
 ;;=3^Malig Neop of Right Lower Limb Connective/Soft Tissue
 ;;^UTILITY(U,$J,358.3,4573,1,4,0)
 ;;=4^C49.21
 ;;^UTILITY(U,$J,358.3,4573,2)
 ;;=^5001129
 ;;^UTILITY(U,$J,358.3,4574,0)
 ;;=C49.22^^22^211^4
 ;;^UTILITY(U,$J,358.3,4574,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4574,1,3,0)
 ;;=3^Malig Neop of Left Lower Limb Connective/Soft Tissue
 ;;^UTILITY(U,$J,358.3,4574,1,4,0)
 ;;=4^C49.22
 ;;^UTILITY(U,$J,358.3,4574,2)
 ;;=^5001130
 ;;^UTILITY(U,$J,358.3,4575,0)
 ;;=C49.3^^22^211^10
 ;;^UTILITY(U,$J,358.3,4575,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4575,1,3,0)
 ;;=3^Malig Neop of Thorax Connective/Soft Tissue
 ;;^UTILITY(U,$J,358.3,4575,1,4,0)
 ;;=4^C49.3
 ;;^UTILITY(U,$J,358.3,4575,2)
 ;;=^5001131
 ;;^UTILITY(U,$J,358.3,4576,0)
 ;;=C49.4^^22^211^1
 ;;^UTILITY(U,$J,358.3,4576,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4576,1,3,0)
 ;;=3^Malig Neop of Abdomen Connective/Soft Tissue
 ;;^UTILITY(U,$J,358.3,4576,1,4,0)
 ;;=4^C49.4
 ;;^UTILITY(U,$J,358.3,4576,2)
 ;;=^5001132
 ;;^UTILITY(U,$J,358.3,4577,0)
 ;;=C49.5^^22^211^7
 ;;^UTILITY(U,$J,358.3,4577,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4577,1,3,0)
 ;;=3^Malig Neop of Pelvis Connective/Soft Tissue
 ;;^UTILITY(U,$J,358.3,4577,1,4,0)
 ;;=4^C49.5
 ;;^UTILITY(U,$J,358.3,4577,2)
 ;;=^5001133
 ;;^UTILITY(U,$J,358.3,4578,0)
 ;;=C49.6^^22^211^11
 ;;^UTILITY(U,$J,358.3,4578,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4578,1,3,0)
 ;;=3^Malig Neop of Trunk Connective/Soft Tissue,Unspec
 ;;^UTILITY(U,$J,358.3,4578,1,4,0)
 ;;=4^C49.6
 ;;^UTILITY(U,$J,358.3,4578,2)
 ;;=^5001134
 ;;^UTILITY(U,$J,358.3,4579,0)
 ;;=C49.8^^22^211^6
 ;;^UTILITY(U,$J,358.3,4579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4579,1,3,0)
 ;;=3^Malig Neop of Overlapping Sites of Connective/Soft Tissue
 ;;^UTILITY(U,$J,358.3,4579,1,4,0)
 ;;=4^C49.8
 ;;^UTILITY(U,$J,358.3,4579,2)
 ;;=^5001135
 ;;^UTILITY(U,$J,358.3,4580,0)
 ;;=C49.9^^22^211^2
 ;;^UTILITY(U,$J,358.3,4580,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4580,1,3,0)
 ;;=3^Malig Neop of Connective/Soft Tissue,Unspec
 ;;^UTILITY(U,$J,358.3,4580,1,4,0)
 ;;=4^C49.9
 ;;^UTILITY(U,$J,358.3,4580,2)
 ;;=^5001136
 ;;^UTILITY(U,$J,358.3,4581,0)
 ;;=C15.3^^22^212^5
 ;;^UTILITY(U,$J,358.3,4581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4581,1,3,0)
 ;;=3^Malig Neop of Upper Third of Esophagus
 ;;^UTILITY(U,$J,358.3,4581,1,4,0)
 ;;=4^C15.3
 ;;^UTILITY(U,$J,358.3,4581,2)
 ;;=^267059
 ;;^UTILITY(U,$J,358.3,4582,0)
 ;;=C15.4^^22^212^3
 ;;^UTILITY(U,$J,358.3,4582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4582,1,3,0)
 ;;=3^Malig Neop of Middle Third of Esophagus
 ;;^UTILITY(U,$J,358.3,4582,1,4,0)
 ;;=4^C15.4
 ;;^UTILITY(U,$J,358.3,4582,2)
 ;;=^267060
 ;;^UTILITY(U,$J,358.3,4583,0)
 ;;=C15.5^^22^212^2
 ;;^UTILITY(U,$J,358.3,4583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4583,1,3,0)
 ;;=3^Malig Neop of Lower Third of Esophagus
 ;;^UTILITY(U,$J,358.3,4583,1,4,0)
 ;;=4^C15.5
 ;;^UTILITY(U,$J,358.3,4583,2)
 ;;=^267061
 ;;^UTILITY(U,$J,358.3,4584,0)
 ;;=C15.8^^22^212^4
 ;;^UTILITY(U,$J,358.3,4584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4584,1,3,0)
 ;;=3^Malig Neop of Overlapping Sites of Esophagus
 ;;^UTILITY(U,$J,358.3,4584,1,4,0)
 ;;=4^C15.8
 ;;^UTILITY(U,$J,358.3,4584,2)
 ;;=^5000918
 ;;^UTILITY(U,$J,358.3,4585,0)
 ;;=C15.9^^22^212^1
 ;;^UTILITY(U,$J,358.3,4585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4585,1,3,0)
 ;;=3^Malig Neop of Esophagus,Unspec
 ;;^UTILITY(U,$J,358.3,4585,1,4,0)
 ;;=4^C15.9
 ;;^UTILITY(U,$J,358.3,4585,2)
 ;;=^5000919
 ;;^UTILITY(U,$J,358.3,4586,0)
 ;;=C13.0^^22^213^4
 ;;^UTILITY(U,$J,358.3,4586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4586,1,3,0)
 ;;=3^Malig Neop of Postcricoid Region
 ;;^UTILITY(U,$J,358.3,4586,1,4,0)
 ;;=4^C13.0
 ;;^UTILITY(U,$J,358.3,4586,2)
 ;;=^5000912
 ;;^UTILITY(U,$J,358.3,4587,0)
 ;;=C13.1^^22^213^1
 ;;^UTILITY(U,$J,358.3,4587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4587,1,3,0)
 ;;=3^Malig Neop of Aryepiglottic Fold
 ;;^UTILITY(U,$J,358.3,4587,1,4,0)
 ;;=4^C13.1
 ;;^UTILITY(U,$J,358.3,4587,2)
 ;;=^267047
 ;;^UTILITY(U,$J,358.3,4588,0)
 ;;=C13.2^^22^213^5
 ;;^UTILITY(U,$J,358.3,4588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4588,1,3,0)
 ;;=3^Malig Neop of Posterior Wall of Hypopharynx
 ;;^UTILITY(U,$J,358.3,4588,1,4,0)
 ;;=4^C13.2
 ;;^UTILITY(U,$J,358.3,4588,2)
 ;;=^5000913
 ;;^UTILITY(U,$J,358.3,4589,0)
 ;;=C13.8^^22^213^3
 ;;^UTILITY(U,$J,358.3,4589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4589,1,3,0)
 ;;=3^Malig Neop of Overlapping Sites of Hypopharynx
 ;;^UTILITY(U,$J,358.3,4589,1,4,0)
 ;;=4^C13.8
 ;;^UTILITY(U,$J,358.3,4589,2)
 ;;=^5000914
 ;;^UTILITY(U,$J,358.3,4590,0)
 ;;=C13.9^^22^213^2
 ;;^UTILITY(U,$J,358.3,4590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4590,1,3,0)
 ;;=3^Malig Neop of Hypopharynx,Unspec
 ;;^UTILITY(U,$J,358.3,4590,1,4,0)
 ;;=4^C13.9
 ;;^UTILITY(U,$J,358.3,4590,2)
 ;;=^5000915
 ;;^UTILITY(U,$J,358.3,4591,0)
 ;;=C32.0^^22^214^1
 ;;^UTILITY(U,$J,358.3,4591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4591,1,3,0)
 ;;=3^Malig Neop of Glottis
 ;;^UTILITY(U,$J,358.3,4591,1,4,0)
 ;;=4^C32.0
 ;;^UTILITY(U,$J,358.3,4591,2)
 ;;=^267129
 ;;^UTILITY(U,$J,358.3,4592,0)
 ;;=C32.1^^22^214^6
 ;;^UTILITY(U,$J,358.3,4592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4592,1,3,0)
 ;;=3^Malig Neop of Supraglottis
 ;;^UTILITY(U,$J,358.3,4592,1,4,0)
 ;;=4^C32.1
 ;;^UTILITY(U,$J,358.3,4592,2)
 ;;=^267130
 ;;^UTILITY(U,$J,358.3,4593,0)
 ;;=C32.2^^22^214^5
 ;;^UTILITY(U,$J,358.3,4593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4593,1,3,0)
 ;;=3^Malig Neop of Subglottis
 ;;^UTILITY(U,$J,358.3,4593,1,4,0)
 ;;=4^C32.2
 ;;^UTILITY(U,$J,358.3,4593,2)
 ;;=^267131
 ;;^UTILITY(U,$J,358.3,4594,0)
 ;;=C32.3^^22^214^2
 ;;^UTILITY(U,$J,358.3,4594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4594,1,3,0)
 ;;=3^Malig Neop of Laryngeal Cartilage
 ;;^UTILITY(U,$J,358.3,4594,1,4,0)
 ;;=4^C32.3
 ;;^UTILITY(U,$J,358.3,4594,2)
 ;;=^5000954
 ;;^UTILITY(U,$J,358.3,4595,0)
 ;;=C32.8^^22^214^4
 ;;^UTILITY(U,$J,358.3,4595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4595,1,3,0)
 ;;=3^Malig Neop of Overlapping Sites of Larynx
 ;;^UTILITY(U,$J,358.3,4595,1,4,0)
 ;;=4^C32.8
 ;;^UTILITY(U,$J,358.3,4595,2)
 ;;=^5000955
 ;;^UTILITY(U,$J,358.3,4596,0)
 ;;=C32.9^^22^214^3
 ;;^UTILITY(U,$J,358.3,4596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4596,1,3,0)
 ;;=3^Malig Neop of Larynx,Unspec
 ;;^UTILITY(U,$J,358.3,4596,1,4,0)
 ;;=4^C32.9
 ;;^UTILITY(U,$J,358.3,4596,2)
 ;;=^5000956
 ;;^UTILITY(U,$J,358.3,4597,0)
 ;;=C33.^^22^214^7
 ;;^UTILITY(U,$J,358.3,4597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4597,1,3,0)
 ;;=3^Malig Neop of Trachea
 ;;^UTILITY(U,$J,358.3,4597,1,4,0)
 ;;=4^C33.
 ;;^UTILITY(U,$J,358.3,4597,2)
 ;;=^267135
 ;;^UTILITY(U,$J,358.3,4598,0)
 ;;=C34.01^^22^215^11
 ;;^UTILITY(U,$J,358.3,4598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4598,1,3,0)
 ;;=3^Malig Neop of Right Main Bronchus
 ;;^UTILITY(U,$J,358.3,4598,1,4,0)
 ;;=4^C34.01
 ;;^UTILITY(U,$J,358.3,4598,2)
 ;;=^5000958
 ;;^UTILITY(U,$J,358.3,4599,0)
 ;;=C34.02^^22^215^3
 ;;^UTILITY(U,$J,358.3,4599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4599,1,3,0)
 ;;=3^Malig Neop of Left Main Bronchus
 ;;^UTILITY(U,$J,358.3,4599,1,4,0)
 ;;=4^C34.02
 ;;^UTILITY(U,$J,358.3,4599,2)
 ;;=^5000959
 ;;^UTILITY(U,$J,358.3,4600,0)
 ;;=C34.11^^22^215^12
 ;;^UTILITY(U,$J,358.3,4600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4600,1,3,0)
 ;;=3^Malig Neop of Right Upper Lobe of Bronchus/Lung
 ;;^UTILITY(U,$J,358.3,4600,1,4,0)
 ;;=4^C34.11
 ;;^UTILITY(U,$J,358.3,4600,2)
 ;;=^5000961
 ;;^UTILITY(U,$J,358.3,4601,0)
 ;;=C34.12^^22^215^4
 ;;^UTILITY(U,$J,358.3,4601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4601,1,3,0)
 ;;=3^Malig Neop of Left Upper Lobe of Bronchus/Lung
 ;;^UTILITY(U,$J,358.3,4601,1,4,0)
 ;;=4^C34.12
 ;;^UTILITY(U,$J,358.3,4601,2)
 ;;=^5000962
 ;;^UTILITY(U,$J,358.3,4602,0)
 ;;=C34.2^^22^215^6
 ;;^UTILITY(U,$J,358.3,4602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4602,1,3,0)
 ;;=3^Malig Neop of Middle Lobe of Bronchus/Lung
 ;;^UTILITY(U,$J,358.3,4602,1,4,0)
 ;;=4^C34.2
 ;;^UTILITY(U,$J,358.3,4602,2)
 ;;=^267137
 ;;^UTILITY(U,$J,358.3,4603,0)
 ;;=C34.31^^22^215^10
 ;;^UTILITY(U,$J,358.3,4603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4603,1,3,0)
 ;;=3^Malig Neop of Right Lower Lobe of Bronchus/Lung
 ;;^UTILITY(U,$J,358.3,4603,1,4,0)
 ;;=4^C34.31
 ;;^UTILITY(U,$J,358.3,4603,2)
 ;;=^5133321
 ;;^UTILITY(U,$J,358.3,4604,0)
 ;;=C34.32^^22^215^2
 ;;^UTILITY(U,$J,358.3,4604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4604,1,3,0)
 ;;=3^Malig Neop of Left Lower Lobe of Bronchus/Lung
 ;;^UTILITY(U,$J,358.3,4604,1,4,0)
 ;;=4^C34.32
 ;;^UTILITY(U,$J,358.3,4604,2)
 ;;=^5133322
 ;;^UTILITY(U,$J,358.3,4605,0)
 ;;=C34.81^^22^215^8
 ;;^UTILITY(U,$J,358.3,4605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4605,1,3,0)
 ;;=3^Malig Neop of Overlapping Sites Right Bronchus/Lung
 ;;^UTILITY(U,$J,358.3,4605,1,4,0)
 ;;=4^C34.81
 ;;^UTILITY(U,$J,358.3,4605,2)
 ;;=^5000964
 ;;^UTILITY(U,$J,358.3,4606,0)
 ;;=C34.82^^22^215^7
 ;;^UTILITY(U,$J,358.3,4606,1,0)
 ;;=^358.31IA^4^2
