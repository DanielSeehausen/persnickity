Neighborhood.create(:name => "TestNeighborhoodA")
Neighborhood.create(:name => "TestNeighborhoodB")
Neighborhood.create(:name => "TestNeighborhoodC")

Restaurant.create(:name => "TestRest01", :grade => 'A', :zip_code => 00001, :neighborhood_id => 1, :cuisine => "garbage")
Restaurant.create(:name => "TestRest02", :grade => 'B', :zip_code => 00002, :neighborhood_id => 1, :cuisine => "refuse")
Restaurant.create(:name => "TestRest09", :grade => 'A', :zip_code => 00001, :neighborhood_id => 1, :cuisine => "garbage")
Restaurant.create(:name => "TestRest10", :grade => 'B', :zip_code => 00002, :neighborhood_id => 1, :cuisine => "refuse")

Restaurant.create(:name => "TestRest03", :grade => 'C', :zip_code => 00003, :neighborhood_id => 2, :cuisine => "trash")
Restaurant.create(:name => "TestRest13", :grade => 'A', :zip_code => 00001, :neighborhood_id => 2, :cuisine => "garbage")
Restaurant.create(:name => "TestRest14", :grade => 'B', :zip_code => 00002, :neighborhood_id => 2, :cuisine => "refuse")
Restaurant.create(:name => "TestRest15", :grade => 'C', :zip_code => 00003, :neighborhood_id => 2, :cuisine => "trash")

Restaurant.create(:name => "TestRest11", :grade => 'C', :zip_code => 00003, :neighborhood_id => 3, :cuisine => "trash")
Restaurant.create(:name => "TestRest07", :grade => 'C', :zip_code => 00003, :neighborhood_id => 3, :cuisine => "trash")
Restaurant.create(:name => "TestRest06", :grade => 'B', :zip_code => 00002, :neighborhood_id => 3, :cuisine => "refuse")
Restaurant.create(:name => "TestRest05", :grade => 'A', :zip_code => 00001, :neighborhood_id => 3, :cuisine => "garbage")

Restaurant.create(:name => "TestRest08", :grade => 'pending', :zip_code => 00004, :neighborhood_id => 3, :cuisine => "detritus")
Restaurant.create(:name => "TestRest04", :grade => 'pending', :zip_code => 00004, :neighborhood_id => 3, :cuisine => "detritus")
Restaurant.create(:name => "TestRest12", :grade => 'pending', :zip_code => 00004, :neighborhood_id => 3, :cuisine => "detritus")
Restaurant.create(:name => "TestRest16", :grade => 'pending', :zip_code => 00004, :neighborhood_id => 3, :cuisine => "detritus")
