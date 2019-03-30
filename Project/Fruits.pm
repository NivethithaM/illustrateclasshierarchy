package Fruits;

#Initialize price and quantity
sub AddPrice {
	my ($self) = @_;
	my $listoffruit = {
		POMO => '145',
		ORANGE => '200',
		APPLE => '250',
		GRAPES => '100',
	};
	return $listoffruit;
}
sub AddQuantity {
	my ($self) = @_;
	my $quantitylist = {
		POMO => '10',
		ORANGE => '15',
		APPLE => '20',
		GRAPES => '25',
	};
	return $quantitylist;
}

#Method overriding when there is a discount for a specified class of item
sub Discount {

}
1
