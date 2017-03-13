defineClass('SettingViewController', {
            viewDidLoad: function() {
            self.super().viewDidLoad();
            self.navigationItem().setTitle("龙哥威武");
            
            },
            });
require('NSURL,UIImage,CarsInfoHelp,UIColor,UIFont');
defineClass('InfoCarsTableViewCell', {
            updateUseingModel_atIndexPath: function(model, indexPath) {
            self.setModel(model);
            self.carImageView().sd__setImageWithURL_placeholderImage(NSURL.URLWithString(model.coverpic()), UIImage.imageNamed("default_pic"));
            self.carImageView().setUserInteractionEnabled(YES);
            self.carImageView().layer().setCornerRadius(5);
            self.titleLabel().setText(model.title());
            self.tiemLabel().setText(CarsInfoHelp.dateFromTimeInterval((model.time() / 1000)));
            self.tiemLabel().setTextColor(UIColor.redColor());
            self.descLabel().setText(model.subhead());
            self.descLabel().setFont(UIFont.systemFontOfSize(12));
            },
            });
