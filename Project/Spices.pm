package Spices;

#Initialize price and quantity
sub AddPrice {
	my ($self) = @_;
	return {
		CARDOMOM => '30',
		PEPPER => 200,
	};
}

sub AddQuantity {
	my ($self) = @_;
	return {
		CARDOMOM => 25,
		PEPPER => 40,
	};
}

#Method overriding when there is a discount for a specified class of item
sub Discount {

}
1
