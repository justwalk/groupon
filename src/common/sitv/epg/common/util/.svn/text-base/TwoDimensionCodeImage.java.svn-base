package sitv.epg.common.util;

import java.awt.image.BufferedImage;

import jp.sourceforge.qrcode.data.QRCodeImage;

public class TwoDimensionCodeImage implements QRCodeImage {

	BufferedImage bufImg;
	
	public TwoDimensionCodeImage(BufferedImage bufImg) {
		this.bufImg = bufImg;
	}

	public int getHeight() {
		// TODO Auto-generated method stub
		return bufImg.getHeight();
	}

	public int getPixel(int x, int y) {
		// TODO Auto-generated method stub
		return bufImg.getRGB(x, y);
	}

	public int getWidth() {
		// TODO Auto-generated method stub
		return bufImg.getWidth();
	}
}