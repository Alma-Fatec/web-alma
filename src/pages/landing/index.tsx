import React from "react";
import { Link } from "react-router-dom";

export default function Landing() {
  return (
    <div>
      <Link to={"/login"}>
        <p>ir para login</p>
      </Link>
      <Link to={"/register"}>
        <p>ir para registro</p>
      </Link>
    </div>
  );
}
