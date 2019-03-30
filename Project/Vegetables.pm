package Vegetables;

use Data::Dumper;

#Initialize price and quantity
sub AddPrice {
	my ($self) = @_;
	my $listofveg = {
		BEANS => '25',
		CARROT => '34',
		TOMATO => '20',
		ONION => '44',
	};
	return $listofveg;
}

sub AddQuantity {
	my ($self) = @_;
	my $listofquantity = {
		BEANS => '10',
		CARROT => '10',
		TOMATO => '20',
		ONION => '50',
	};
	return $listofquantity;
}

#Method overriding when there is a discount for a specified class of item
sub Discount {

}
1
