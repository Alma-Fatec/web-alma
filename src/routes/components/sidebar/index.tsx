import { useEffect } from "react";

export default function Sidebar() {
  useEffect(() => {
    console.log("salve da sidebar");
  }, []);

  return (
    <nav>
      <ul>
        <li>menu</li>
        <li>menu</li>
        <li>menu</li>
        <li>menu</li>
        <li>menu</li>
      </ul>
    </nav>
  );
}
