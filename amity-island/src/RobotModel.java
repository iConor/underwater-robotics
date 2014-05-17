public class RobotModel {

	public static final float PORT_THRUSTER_CAL = 1.0f;
	public static final float STBD_THRUSTER_CAL = 1.0f;
	public static final float AFT_THRUSTER_CAL = 1.0f;

	private int portThrusterPower;
	private int stbdThrusterPower;
	private int aftThrusterPower;

	private int portThrusterAngle;
	private int stbdThrusterAngle;

	private int cameraPanAngle;
	private int cameraTiltAngle;

	private int yaw;
	private int pitch;
	private int roll;

	private int depthPSI;
	private int depthTemp;

	public RobotModel() {
		this.portThrusterPower = 0;
		this.stbdThrusterPower = 0;
		this.aftThrusterPower = 0;

		this.portThrusterAngle = 90;
		this.stbdThrusterAngle = 90;

		this.cameraPanAngle = 80;
		this.cameraTiltAngle = 70;

		this.yaw = 0;
		this.pitch = 0;
		this.roll = 0;

		this.depthPSI = 0;
		this.depthTemp = 0;
	}

	public RobotModel(RobotModel that) {
		this.portThrusterPower = that.portThrusterPower;
		this.stbdThrusterPower = that.stbdThrusterPower;
		this.aftThrusterPower = that.aftThrusterPower;

		this.portThrusterAngle = that.portThrusterAngle;
		this.stbdThrusterAngle = that.stbdThrusterAngle;

		this.cameraPanAngle = that.cameraPanAngle;
		this.cameraTiltAngle = that.cameraTiltAngle;

		this.yaw = that.yaw;
		this.pitch = that.pitch;
		this.roll = that.roll;

		this.depthPSI = that.depthPSI;
		this.depthTemp = that.depthTemp;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		RobotModel other = (RobotModel) obj;
		if (aftThrusterPower != other.aftThrusterPower)
			return false;
		if (cameraPanAngle != other.cameraPanAngle)
			return false;
		if (cameraTiltAngle != other.cameraTiltAngle)
			return false;
		if (depthPSI != other.depthPSI)
			return false;
		if (depthTemp != other.depthTemp)
			return false;
		if (pitch != other.pitch)
			return false;
		if (portThrusterAngle != other.portThrusterAngle)
			return false;
		if (portThrusterPower != other.portThrusterPower)
			return false;
		if (roll != other.roll)
			return false;
		if (stbdThrusterAngle != other.stbdThrusterAngle)
			return false;
		if (stbdThrusterPower != other.stbdThrusterPower)
			return false;
		if (yaw != other.yaw)
			return false;
		return true;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("RobotModel [portThrusterPower=");
		builder.append(portThrusterPower);
		builder.append(", stbdThrusterPower=");
		builder.append(stbdThrusterPower);
		builder.append(", aftThrusterPower=");
		builder.append(aftThrusterPower);
		builder.append(", portThrusterAngle=");
		builder.append(portThrusterAngle);
		builder.append(", stbdThrusterAngle=");
		builder.append(stbdThrusterAngle);
		builder.append(", cameraPanAngle=");
		builder.append(cameraPanAngle);
		builder.append(", cameraTiltAngle=");
		builder.append(cameraTiltAngle);
		builder.append(", yaw=");
		builder.append(yaw);
		builder.append(", pitch=");
		builder.append(pitch);
		builder.append(", roll=");
		builder.append(roll);
		builder.append(", depthPSI=");
		builder.append(depthPSI);
		builder.append(", depthTemp=");
		builder.append(depthTemp);
		builder.append("]");
		return builder.toString();
	}

	/**
	 * @return the portThrusterPower
	 */
	public int getPortThrusterPower() {
		return portThrusterPower;
	}

	/**
	 * @param portThrusterPower
	 *            the portThrusterPower to set
	 */
	public void setPortThrusterPower(int portThrusterPower) {
		this.portThrusterPower = portThrusterPower;
	}

	/**
	 * @return the stbdThrusterPower
	 */
	public int getStbdThrusterPower() {
		return stbdThrusterPower;
	}

	/**
	 * @param stbdThrusterPower
	 *            the stbdThrusterPower to set
	 */
	public void setStbdThrusterPower(int stbdThrusterPower) {
		this.stbdThrusterPower = stbdThrusterPower;
	}

	/**
	 * @return the aftThrusterPower
	 */
	public int getAftThrusterPower() {
		return aftThrusterPower;
	}

	/**
	 * @param aftThrusterPower
	 *            the aftThrusterPower to set
	 */
	public void setAftThrusterPower(int aftThrusterPower) {
		this.aftThrusterPower = aftThrusterPower;
	}

	/**
	 * @return the portThrusterAngle
	 */
	public int getPortThrusterAngle() {
		return portThrusterAngle;
	}

	/**
	 * @param portThrusterAngle
	 *            the portThrusterAngle to set
	 */
	public void setPortThrusterAngle(int portThrusterAngle) {
		this.portThrusterAngle = portThrusterAngle;
	}

	/**
	 * @return the stbdThrusterAngle
	 */
	public int getStbdThrusterAngle() {
		return stbdThrusterAngle;
	}

	/**
	 * @param stbdThrusterAngle
	 *            the stbdThrusterAngle to set
	 */
	public void setStbdThrusterAngle(int stbdThrusterAngle) {
		this.stbdThrusterAngle = stbdThrusterAngle;
	}

	/**
	 * @return the cameraPanAngle
	 */
	public int getCameraPanAngle() {
		return cameraPanAngle;
	}

	/**
	 * @param cameraPanAngle
	 *            the cameraPanAngle to set
	 */
	public void setCameraPanAngle(int cameraPanAngle) {
		this.cameraPanAngle = cameraPanAngle;
	}

	/**
	 * @return the cameraTiltAngle
	 */
	public int getCameraTiltAngle() {
		return cameraTiltAngle;
	}

	/**
	 * @param cameraTiltAngle
	 *            the cameraTiltAngle to set
	 */
	public void setCameraTiltAngle(int cameraTiltAngle) {
		this.cameraTiltAngle = cameraTiltAngle;
	}

	/**
	 * @return the yaw
	 */
	public int getYaw() {
		return yaw;
	}

	/**
	 * @param yaw
	 *            the yaw to set
	 */
	public void setYaw(int yaw) {
		this.yaw = yaw;
	}

	/**
	 * @return the pitch
	 */
	public int getPitch() {
		return pitch;
	}

	/**
	 * @param pitch
	 *            the pitch to set
	 */
	public void setPitch(int pitch) {
		this.pitch = pitch;
	}

	/**
	 * @return the roll
	 */
	public int getRoll() {
		return roll;
	}

	/**
	 * @param roll
	 *            the roll to set
	 */
	public void setRoll(int roll) {
		this.roll = roll;
	}

	/**
	 * @return the depthPSI
	 */
	public int getDepthPSI() {
		return depthPSI;
	}

	/**
	 * @param depthPSI
	 *            the depthPSI to set
	 */
	public void setDepthPSI(int depthPSI) {
		this.depthPSI = depthPSI;
	}

	/**
	 * @return the depthTemp
	 */
	public int getDepthTemp() {
		return depthTemp;
	}

	/**
	 * @param depthTemp
	 *            the depthTemp to set
	 */
	public void setDepthTemp(int depthTemp) {
		this.depthTemp = depthTemp;
	}

}
