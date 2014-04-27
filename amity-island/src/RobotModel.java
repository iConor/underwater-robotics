public class RobotModel {

	private float yaw;
	private float pitch;
	private float roll;

	private float depthPSI;
	private float depthTemp;

	private float portThrusterPower;
	private int portThrusterAngle;

	private float stbdThrusterPower;
	private int stbdThrusterAngle;

	private float aftThrusterPower;

	private int cameraPanAngle;
	private int cameraTiltAngle;

	public RobotModel() {
		this.yaw = 0;
		this.pitch = 0;
		this.roll = 0;
		this.depthPSI = 0;
		this.depthTemp = 0;
		this.portThrusterPower = 0;
		this.portThrusterAngle = 90;
		this.stbdThrusterPower = 0;
		this.stbdThrusterAngle = 90;
		this.aftThrusterPower = 0;
		this.cameraPanAngle = 90;
		this.cameraTiltAngle = 90;
	}

	public RobotModel(RobotModel that) {
		this.yaw = that.yaw;
		this.pitch = that.pitch;
		this.roll = that.roll;
		this.depthPSI = that.depthPSI;
		this.depthTemp = that.depthTemp;
		this.portThrusterPower = that.portThrusterPower;
		this.portThrusterAngle = that.portThrusterAngle;
		this.stbdThrusterPower = that.stbdThrusterPower;
		this.stbdThrusterAngle = that.stbdThrusterAngle;
		this.aftThrusterPower = that.aftThrusterPower;
		this.cameraPanAngle = that.cameraPanAngle;
		this.cameraTiltAngle = that.cameraTiltAngle;
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
		if (Float.floatToIntBits(depthPSI) != Float
				.floatToIntBits(other.depthPSI))
			return false;
		if (Float.floatToIntBits(depthTemp) != Float
				.floatToIntBits(other.depthTemp))
			return false;
		if (Float.floatToIntBits(pitch) != Float.floatToIntBits(other.pitch))
			return false;
		if (portThrusterAngle != other.portThrusterAngle)
			return false;
		if (portThrusterPower != other.portThrusterPower)
			return false;
		if (Float.floatToIntBits(roll) != Float.floatToIntBits(other.roll))
			return false;
		if (stbdThrusterAngle != other.stbdThrusterAngle)
			return false;
		if (stbdThrusterPower != other.stbdThrusterPower)
			return false;
		if (Float.floatToIntBits(yaw) != Float.floatToIntBits(other.yaw))
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
		builder.append("RobotModel [yaw=");
		builder.append(yaw);
		builder.append(", pitch=");
		builder.append(pitch);
		builder.append(", roll=");
		builder.append(roll);
		builder.append(", depthPSI=");
		builder.append(depthPSI);
		builder.append(", depthTemp=");
		builder.append(depthTemp);
		builder.append(", portThrusterPower=");
		builder.append(portThrusterPower);
		builder.append(", portThrusterAngle=");
		builder.append(portThrusterAngle);
		builder.append(", stbdThrusterPower=");
		builder.append(stbdThrusterPower);
		builder.append(", stbdThrusterAngle=");
		builder.append(stbdThrusterAngle);
		builder.append(", aftThrusterPower=");
		builder.append(aftThrusterPower);
		builder.append(", cameraPanAngle=");
		builder.append(cameraPanAngle);
		builder.append(", cameraTiltAngle=");
		builder.append(cameraTiltAngle);
		builder.append("]");
		return builder.toString();
	}

	/**
	 * @return the yaw
	 */
	public float getYaw() {
		return yaw;
	}

	/**
	 * @param yaw
	 *            the yaw to set
	 */
	public void setYaw(float yaw) {
		this.yaw = yaw;
	}

	/**
	 * @return the pitch
	 */
	public float getPitch() {
		return pitch;
	}

	/**
	 * @param pitch
	 *            the pitch to set
	 */
	public void setPitch(float pitch) {
		this.pitch = pitch;
	}

	/**
	 * @return the roll
	 */
	public float getRoll() {
		return roll;
	}

	/**
	 * @param roll
	 *            the roll to set
	 */
	public void setRoll(float roll) {
		this.roll = roll;
	}

	/**
	 * @return the depthPSI
	 */
	public float getDepthPSI() {
		return depthPSI;
	}

	/**
	 * @param depthPSI
	 *            the depthPSI to set
	 */
	public void setDepthPSI(float depthPSI) {
		this.depthPSI = depthPSI;
	}

	/**
	 * @return the depthTemp
	 */
	public float getDepthTemp() {
		return depthTemp;
	}

	/**
	 * @param depthTemp
	 *            the depthTemp to set
	 */
	public void setDepthTemp(float depthTemp) {
		this.depthTemp = depthTemp;
	}

	/**
	 * @return the portThrusterPower
	 */
	public float getPortThrusterPower() {
		return portThrusterPower;
	}

	/**
	 * @param portThrusterPower
	 *            the portThrusterPower to set
	 */
	public void setPortThrusterPower(float portThrusterPower) {
		this.portThrusterPower = portThrusterPower;
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
	public void setPortThrusterAngle(float portThrusterAngle) {
		this.portThrusterAngle = (int) portThrusterAngle;
	}

	/**
	 * @return the stbdThrusterPower
	 */
	public float getStbdThrusterPower() {
		return stbdThrusterPower;
	}

	/**
	 * @param stbdThrusterPower
	 *            the stbdThrusterPower to set
	 */
	public void setStbdThrusterPower(float stbdThrusterPower) {
		this.stbdThrusterPower = stbdThrusterPower;
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
	public void setStbdThrusterAngle(float stbdThrusterAngle) {
		this.stbdThrusterAngle = (int) stbdThrusterAngle;
	}

	/**
	 * @return the aftThrusterPower
	 */
	public float getAftThrusterPower() {
		return aftThrusterPower;
	}

	/**
	 * @param aftThrusterPower
	 *            the aftThrusterPower to set
	 */
	public void setAftThrusterPower(float aftThrusterPower) {
		this.aftThrusterPower = -aftThrusterPower;
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

}
