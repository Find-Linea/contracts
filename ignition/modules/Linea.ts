import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const LineaModule = buildModule("Linea", (m) => {
  const linea = m.contract("Linea");

  return { linea };
});

export default LineaModule;
