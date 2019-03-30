package Cookies;

#Initialize price and quantity
sub AddPrice {
	my ($self) = @_;
	return {
		TIGER => 10,
		HIDEANDSEEK => 20,
		PARLEG => 15,
		MILKBIKIS => 10,
	};
}

sub AddQuantity {
	my ($self) = @_;
	return {
		TIGER => 50,
		HIDEANDSEEK => 100,
		PARLEG => 23,
		MILKBIKIS => 75,
	};
}

#Method overriding when there is a discount for a specified class of item
sub Discount {
	my ($self) = @_;
	return '20';
}
1
